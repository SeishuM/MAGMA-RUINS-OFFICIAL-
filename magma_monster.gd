extends KinematicBody2D
const GRAVITY = 10
const SPEED = 25
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1

var is_dead = false

func is_dead():
	return is_dead

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$magma_monster_sprite.play("dead")
	$magma_monster_shape.set_disabled(true)
	#$CollisionShape2D.disabled = true
	$magma_monster_area/magma_monster_area_shape.set_disabled(true)
	
	$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		if direction == 1:
			$magma_monster_sprite.flip_h = false
		else:
			$magma_monster_sprite.flip_h = true
		$magma_monster_sprite.play("walk")

		velocity.y += GRAVITY

		velocity = move_and_slide(velocity, FLOOR)

	if is_on_wall():
		direction = direction * -1
		$magma_monster_RayCast2D.position.x *= -1

	if $magma_monster_RayCast2D.is_colliding() == false:
		direction = direction * -1
		$magma_monster_RayCast2D.position.x *= -1

		
func _on_Timer_timeout():
	queue_free()