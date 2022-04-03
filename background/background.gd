extends Node2D

signal done

const row = preload("res://background/row.tscn")
const end = preload("res://background/end_tunnel.tscn")
var rows := []
var player
var is_gameover := false
var is_done := false

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

	if not is_gameover:
		for row in rows:
			if player != null:
				row.position.y += player.speed * _delta

		if rows.back().position.y > get_viewport().size.y:
			var row = rows.pop_back()
			row.position.y = rows.front().position.y - 64
			rows.push_front(row)
	elif not is_done:
		if rows[0].position.y < 0:
			for row in rows:
				if player != null:
					row.position.y += player.speed * _delta
		else:
			emit_signal("done")
			is_done = true

func gameover():
	var obj = end.instance()
	obj.position.y = rows.front().position.y - 192
	add_child(obj)
	rows.push_front(obj)
	is_gameover = true
