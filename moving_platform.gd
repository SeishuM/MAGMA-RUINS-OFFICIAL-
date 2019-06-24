extends Node2D

var speed
var distance
var move_to

func _ready():
	pass

func set_moving_platform(tiles_per_second, idle_seconds, pixel_distance, direction):
	
	speed = tiles_per_second
	if direction == "UP":
		move_to = Vector2.UP * distance
	elif direction == "DOWN":
		move_to = Vector2.DOWN * distance
	elif direction == "LEFT":
		move_to = Vector2.LEFT * distance
	else:
		move_to = Vector2.RIGHT * distance
	return move_to

