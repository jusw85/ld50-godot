extends Node2D


onready var player = $YSort/Player

func _ready():
	randomize()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _process(_delta):
	if player.speed >= 1000:
		player.gameover()
		$YSort/Spawner/Timer.stop()


func _on_Tween_tween_completed(object, key):
	$Background.gameover()
