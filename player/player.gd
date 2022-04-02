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
