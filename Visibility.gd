extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Visibility_area_body_entered(body):
	if get_parent().is_dead() == false:
		if "Player" in body.name:
			# remove next line once health is implimented
			get_tree().change_scene("Level2.tscn")
		else:
			pass
