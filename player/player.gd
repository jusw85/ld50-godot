# warning-ignore-all:return_value_discarded

extends KinematicBody2D

enum State { RUNNING, }

export var speed := 100.0

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
	change_speed(10 * get_physics_process_delta_time(), Globals.DeltaType.ABSOLUTE)
	change_speed(1.02, Globals.DeltaType.RELATIVE)
	var dir = directional_input.get_input_direction()
	move_and_slide(Vector2(dir.x * 400, 0))

func change_speed(delta, typ):
	if typ == Globals.DeltaType.ABSOLUTE:
		speed += delta
	elif typ == Globals.DeltaType.RELATIVE:
		speed *= delta
	speed = clamp(speed, 10, 1000)
	animated_sprite.speed_scale = (((speed - 10.0) / 1000.0) * (1.5 - 0.5)) + 0.5
