extends Area2D

const SPEED = 350
var velocity = Vector2()
var direction = 1

func _ready():
	pass

func set_spike_direction(dir):
	direction = dir
	if dir == -1:
		$shooting_spike_sprite.flip_h = false

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)

func _on_shooting_spike_area_body_entered(body):
	if "Player" in body.name:
		body.dead1()
	queue_free()

#func _on_shooting_spike_notifier_screen_exited():
