extends KinematicBody2D

signal Player

func _ready():
	randomize()


func _on_LavaDrops_body_entered( body ):
	if body.get_name() == "CastleTiles":
		emit_signal("Player", position)
		queue_free()
