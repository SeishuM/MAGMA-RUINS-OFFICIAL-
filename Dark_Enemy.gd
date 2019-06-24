extends KinematicBody2D
export (int) var detect_radius
export (float) var fire_rate
export(PackedScene) var DragonFire

const GRAVITY = 10
const SPEED = 100
const FLOOR = Vector2(0, -1)


var velocity = Vector2()
var vis_color = Color(0, 0, 0, 0)
var direction = 1

var is_dead = false
var hit_pos
var target
var can_shoot = true
var laser_color = Color(1.0, .329, .298)

func is_dead():
	return is_dead

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$Dark_Enemy_Sprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	
func _ready():
	randomize()
	#$Sprite.self_modulate = Color(0, 0, 0)
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2.shape = shape
	$ShootTimer.wait_time = fire_rate

func _physics_process(delta):
	if is_dead == false:
		update()
		velocity.x = SPEED * direction
		if direction == 1:
			$Dark_Enemy_Sprite.flip_h = false
		else:
			$Dark_Enemy_Sprite.flip_h = true
		$Dark_Enemy_Sprite.play("run")

		velocity.y += GRAVITY

		velocity = move_and_slide(velocity, FLOOR)
		if target:
			aim()
		
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "player_body" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()


	if is_on_wall():
		direction = direction * -1
		$Dark_Enemy_RayCast2D.position.x *= -1

	if $Dark_Enemy_RayCast2D.is_colliding() == false:
		direction = direction * -1
		$Dark_Enemy_RayCast2D.position.x *= -1
		
		


func aim():
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	#var target_extents = target.get_node('CollisionShape2D').shape.extents - Vector2(5, 5)
	#var nw = target.position - target_extents
	#var se = target.position + target_extents
	#var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	#var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	#for pos in [target.position, nw, ne, se, sw]:
	var result = space_state.intersect_ray(position, target.position, [self], collision_mask)
	if result:
		hit_pos.append(result.position)
		if result.collider.name == "player_body":
			$Dark_Enemy_Sprite.self_modulate.r 
			#rotation = (target.position + position).angle()
			#if can_shoot:
				#shoot(target.position)
				
func shoot(pos):

	var a = (pos - global_position).angle()
	var b = DragonFire.instance()
	b.start(global_position, a + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
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
		#Sprite.self_modulate.r = 0.2
		

func _on_Timer_timeout():
	queue_free()


func _on_ShootTimer_timeout():
	can_shoot = true
