extends Area2D

func _ready():
	pass 



func _on_skeleton_area_body_entered(body):
	if "Player" in body.name:
		# remove next line once health is implimented
		get_tree().reload_current_scene()
	else:
		pass
