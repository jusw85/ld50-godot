# warning-ignore-all:return_value_discarded

extends KinematicBody2D

enum State { RUNNING, END, END2 }

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
	change_speed(1.002, Globals.DeltaType.RELATIVE)
	var dir = directional_input.get_input_direction()
	move_and_slide(Vector2(dir.x * 400, 0))

func _enter_end():
	$Tween.interpolate_property(self, "speed", speed, 200, 4.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func _process_end():
	pass

func _enter_end2():
	pass

func _process_end2():
	move_and_slide(Vector2(0, -speed))

func change_speed(delta, typ):
	if _fsm.state == State.END:
		return

	if typ == Globals.DeltaType.ABSOLUTE:
		speed += delta
	elif typ == Globals.DeltaType.RELATIVE:
		speed *= delta
	speed = clamp(speed, 10, 1000)
	animated_sprite.speed_scale = (((speed - 10.0) / 1000.0) * (1.5 - 0.5)) + 0.5

func gameover():
	_fsm.change_state(State.END)

func _on_Background_done():
	_fsm.change_state(State.END2)
