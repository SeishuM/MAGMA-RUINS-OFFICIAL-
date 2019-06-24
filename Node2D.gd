extends Node2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var motion = Vector2()

var direction = 1

func _ready():
	pass

func _physics_process(delta):
	motion.x = SPEED * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

	$AnimatedSprite.play("default")

	motion.y += GRAVITY

	motion = move_and_slide(motion, FLOOR)

	if is_on_wall():
		direction = direction * -1
	

	if $RayCast2D.is_collide_with_bodies_enabled() == false:
		direction = direction * -1
