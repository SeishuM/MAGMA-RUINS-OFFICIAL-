extends Node2D

#how long platform pauses at either end
const IDLE_DURATION = 1.0

#how far platform travels (use multiple of 32)
export var move_to = Vector2.UP * 640

#tiles/sec
export var speed = 10.0

#ease instead of jerk platform
var follow = Vector2.ZERO

onready var tween = $lvl5_p1_Tween

func _ready():
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 32)
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()

func _physics_process(delta):
	$lvl5_p1_body.position = $lvl5_p1_body.position.linear_interpolate(follow, 0.075)
