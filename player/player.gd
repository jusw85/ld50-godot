extends KinematicBody2D

enum State { RUNNING, }

export var speed := 300.0

var _fsm: NC.StateMachine

onready var directional_input: NC.DirectionalInput = $DirectionalInput
onready var animated_sprite = $AnimatedSprite

func _ready():
	_fsm = NC.StateMachine.new()
	_fsm.init_funcs(self, State)
	_fsm.change_state(State.RUNNING)

func _physics_process(_delta) -> void:
	_fsm.process_state()

func _enter_running():
	pass

func _process_running():
	var dir = directional_input.get_input_direction()
	move_and_slide(Vector2(dir.x * speed, 0))

func change_speed(delta):
	speed += delta
	speed = clamp(speed, 100, 500)
	animated_sprite.speed_scale = (((speed - 100.0) / 500.0) * (1.5 - 0.5)) + 0.5
