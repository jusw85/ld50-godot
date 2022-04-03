extends Area2D

export var speed_delta = 1.0
var player

func _ready():
	pass


func _process(_delta) -> void:
	if player == null:
		var a = get_tree().get_nodes_in_group("player")
		if a.size() > 0:
			player = a.front()
	if player != null:
		position.y += player.speed * _delta


func _on_body_entered(body):
	body.change_speed(speed_delta, Globals.DeltaType.RELATIVE)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
