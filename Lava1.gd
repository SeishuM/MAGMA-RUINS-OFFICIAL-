extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Lava_body_entered(body):
	if "Player" in body.name:
		get_tree().reload_current_scene()
	pass # Replace with function body.

