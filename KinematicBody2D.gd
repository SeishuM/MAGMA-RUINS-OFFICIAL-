extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 300
const JUMP_HEIGHT = -600

const FIREBALL = preload("res://Fireball.tscn")

var motion = Vector2()


# warning-ignore:unused_argument
func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("run0")
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("run0")
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		$Sprite.play("idle")
		motion.x = 0
	
	if Input.is_action_just_pressed("ui_focus_next"):
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
	
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play("jump")
	
	motion = move_and_slide(motion, UP)
	pass
	