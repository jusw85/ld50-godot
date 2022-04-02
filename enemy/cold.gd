extends Area2D

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


func _on_Cold_body_entered(body):
	body.change_speed(-50)
	queue_free()
