extends Area2D

var speed := 200.0


func _ready():
	pass


func _process(_delta) -> void:
	position.y += speed * _delta


func _on_Cold_body_entered(body):
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.speed -= 50
		enemy.speed = clamp(enemy.speed, 100, 500)
	queue_free()
