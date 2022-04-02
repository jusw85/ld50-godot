extends Area2D


var _extents

var _enemies = [preload("res://enemy/cold.tscn"),
				preload("res://enemy/hot.tscn")]


func _ready():
	var shape = $CollisionShape2D.shape
	_extents = shape.extents


func _spawn():
	var pos := Vector2()
	pos.x = rand_range(0, _extents.x) - (_extents.x/2)
	pos.y = rand_range(0, _extents.y) - (_extents.y/2)

	var spawn = _enemies[randi() % 2].instance()
	spawn.position = pos
	add_child(spawn)



func _on_Timer_timeout():
	_spawn()
