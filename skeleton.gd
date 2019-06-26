extends KinematicBody2D
export var health = 5
const GRAVITY = 10
const SPEED = 75
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
const SPIKE = preload("res://shooting_spike.tscn")

var direction = 1

var is_dead = false

func is_dead():
	return is_dead

func dead():
	health = health - 1
	if health <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$skeleton_sprite.play("dead")
		$skeleton_shape.set_disabled(true)
		$skeleton_area/skeleton_area_shape.set_disabled(true)
	
	$skeleton_death_timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		if direction == 1:
			$skeleton_sprite.flip_h = false
			if sign($skeleton_position.position.x) == -1:
				$skeleton_position.position.x *= -1
		else:
			$skeleton_sprite.flip_h = true
			if sign($skeleton_position.position.x) == 1:
				$skeleton_position.position.x *= -1
		$skeleton_sprite.play("walk")

		velocity.y += GRAVITY

		velocity = move_and_slide(velocity, FLOOR)

	if is_on_wall():
		direction = direction * -1
		$skeleton_RayCast2D.position.x *= -1
		$skeleton_position.position.x *= -1
	if $skeleton_RayCast2D.is_colliding() == false:
		direction = direction * -1
		$skeleton_RayCast2D.position.x *= -1
		$skeleton_position.position.x *= -1

func _on_skeleton_death_timer_timeout():
	queue_free()
	

func _on_skeleton_spike_timer_timeout():
	
	var spike = SPIKE.instance()
	spike.set_spike_direction(direction)
	get_parent().add_child(spike)
	spike.global_position = $skeleton_position.global_position
