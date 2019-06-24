extends Area2D

func _ready():
	pass

func _on_lvl1_lava_area_body_entered(body):
	if "Player" in body.name:
		get_tree().reload_current_scene()
	else:
		pass
