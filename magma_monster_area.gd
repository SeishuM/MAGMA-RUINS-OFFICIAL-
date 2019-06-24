extends Area2D

func _ready():
	pass 

# enter code to lower health here
func _on_magma_monster_area_body_entered(body):
	if get_parent().is_dead() == false:
		if "Player" in body.name:
			# remove next line once health is implimented
			get_tree().reload_current_scene()
	else:
		pass
