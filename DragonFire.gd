extends Area2D

export var strength = 6
var speed = 1000
var velocity = Vector2()

func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_DragonFire_body_entered(body):
	if "Player" in body.name:
		body.dead()
	queue_free()
