extends Node2D


const row = preload("res://background/row.tscn")
var rows := []
var player

func _ready():
	var y = -64;
	while y < get_viewport().size.y:
		var obj = row.instance()
		obj.position.y = y
		add_child(obj)
		rows.push_back(obj)
		y += 64

func _process(_delta):
	if player == null:
		var a = get_tree().get_nodes_in_group("player")
		if a.size() > 0:
			player = a.front()

	for row in rows:
		if player != null:
			row.position.y += player.speed * _delta

	if rows.back().position.y > get_viewport().size.y:
		var row = rows.pop_back()
		row.position.y = rows.front().position.y - 64
		rows.push_front(row)
