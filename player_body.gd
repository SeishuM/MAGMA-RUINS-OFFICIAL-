extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 8
const ACCELERATION = 50
const MAX_SPEED = 450
const JUMP_HEIGHT = -360

const FIREBALL = preload("res://Fireball.tscn")

var motion = Vector2()
var is_dead = false

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if is_dead == false:
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$player_sprite.flip_h = false
			$player_sprite.play("run")
			if sign($player_position.position.x) == -1:
				$player_position.position.x *= -1
			
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$player_sprite.flip_h = true
			$player_sprite.play("run")
			if sign($player_position.position.x) == 1:
				$player_position.position.x *= -1
		else:
			$player_sprite.play("idle")
			friction = true


		if Input.is_action_just_pressed("ui_focus_next"):
				var fireball = FIREBALL.instance()
				if sign($player_position.position.x) == 1:
					fireball.set_fireball_direction(1)
				else:
					fireball.set_fireball_direction(-1)
				get_parent().add_child(fireball)
				fireball.position = $player_position.global_position



		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$player_sprite.play("up")
			else:
				$player_sprite.play("down")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)

		motion = move_and_slide(motion, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Turret" in get_slide_collision(i).collider.name:
					dead()

	
func dead():
	is_dead = true
	motion = Vector2(0,0)
	$player_sprite.play("dead")
	#$CollisionShape2D.disabled = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("Level2.tscn")
