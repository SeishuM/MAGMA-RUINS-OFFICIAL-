extends KinematicBody2D



export (int) var detect_radius
export (float) var fire_rate
export (PackedScene) var Bullet
export(PackedScene) var DragonFire
onready var Player = get_parent().get_node("Player")
var vis_color = Color(0, 0, 0, 0)
var laser_color = Color(1.0, .329, .298)

var velocity = Vector2()
const SPEED = 100
const FLOOR = Vector2(0, -1)
var direction = 0
var target
var hit_pos
var can_shoot = true
var is_dead = false

var react_time = 600
var next_direction = 0
var next_dir_time = 0
var target_player_dist = 200

func is_dead():
	return is_dead

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$Sprite.play("dead")

	$TurretShape1.call_deferred("set_disabled", true)
	
	$Timer.start()
	
func _ready():
	set_process(true)
	randomize()
	#$Sprite.self_modulate = Color(0, 0, 0)
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/TurretShape2.shape = shape
	$ShootTimer.wait_time = fire_rate
func set_dir(target_direction):
	if next_direction != target_direction:
		next_direction = target_direction
		next_dir_time = OS.get_ticks_msec() + react_time

func _physics_process(delta):
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()
	if is_dead == false:
		update()
		#velocity.x = SPEED * direction
		if Player.position.x < position.x - target_player_dist:
			set_dir(-1)
		elif Player.position.x > position.x + target_player_dist:
			set_dir(1)
		else:
			set_dir(0)
			
		if OS.get_ticks_msec() > next_dir_time:
			direction = next_direction
			
		velocity.x = direction * 200
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		$Sprite.play("idle")



		velocity = move_and_slide(velocity, FLOOR)
		if target:
			aim()

func aim():
	hit_pos = []
	var space_state = get_world_2d().direct_space_state

	var result = space_state.intersect_ray(position, target.position, [self], collision_mask)
	if result:
		hit_pos.append(result.position)
		if result.collider.name == "Player":
			$Sprite.self_modulate.r 
			if can_shoot:
				shoot(target.position)
			
func shoot(pos):
	var c = DragonFire.instance()
	var a = (pos - global_position).angle()
	
	c.start(global_position, a + rand_range(-0.10, 0.10))
	get_parent().add_child(c)
	can_shoot = false
	$ShootTimer.start()

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)
	if target:
		for hit in hit_pos:
			draw_circle((hit - position).rotated(-rotation), 5, laser_color)
			draw_line(Vector2(), (hit - position).rotated(-rotation), laser_color)

func _on_Visibility_body_entered(body):
	if target:
		return
	target = body


func _on_Visibility_body_exited(body):
	if body == target:
		target = null


func _on_ShootTimer_timeout():
	can_shoot = true

func _on_Timer_timeout():
	queue_free()
