extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 50
const MAX_SPEED = 450
const JUMP_HEIGHT = -380

const FIREBALL = preload("res://Fireball.tscn")

signal health_changed
signal died

var motion = Vector2()
var is_dead = false

export var max_health = 100
var health = max_health

enum STATES {ALIVE, DEAD}
var state = STATES.ALIVE

###func take_damage(count):
##	#if state == STATES.DEAD:
#		return
#
#	health -= count
#	if health <= 0:
#		health = 0
#		state = STATES.DEAD
#		emit_signal("died")
#
#	$AnimationPlayer.play("take_hit")

	#emit_signal("health_changed", health)

#func _on_AnimationPlayer_animation_finished( name ):
#	if state != STATES.DEAD:
#		return
#	if name != "take_hit":
#		return
#
#	$AnimationPlayer.play("die")


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
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "skeleton" in get_slide_collision(i).collider.name:
					dead1()

func dead():
	max_health = max_health - 20
	emit_signal("health_changed", max_health)

	if max_health <= 0:
		is_dead = true
		motion = Vector2(0,0)
		$player_sprite.play("dead")
		$Timer.start()

func dead1():
	max_health = max_health - 10
	emit_signal("health_changed", max_health)

	if max_health <= -9:
		is_dead = true
		motion = Vector2(0,0)
		$player_sprite.play("dead")
		get_tree().change_scene("res://Level 1.tscn")

func dead2():
	max_health = max_health - 5
	emit_signal("health_changed", max_health)

	if max_health <= 0:
		is_dead = true
		motion = Vector2(0,0)
		$player_sprite.play("dead")
		$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("Level 1.tscn")

#func _on_Timer2_timeout():

