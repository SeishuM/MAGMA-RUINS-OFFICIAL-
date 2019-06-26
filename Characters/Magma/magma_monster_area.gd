extends Area2D

func _ready():
	pass 

# enter code to lower health here
func _on_magma_monster_area_body_entered(body):
	if "Player" in body.name:
		body.dead()
	queue_free()
	pass
