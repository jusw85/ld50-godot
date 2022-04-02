extends Area2D

var speed := 200.0


func _ready():
	pass


func _process(_delta) -> void:
	position.y += speed * _delta


func _on_Hot_area_entered(area):
	print("area entered")


func _on_Hot_body_entered(body):
	print("body entered")
