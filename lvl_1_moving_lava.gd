extends Node2D


#how long platform pauses at either end
const IDLE_DURATION = 0.0

#how far platform travels (use multiple of 32)
export var move_to = Vector2.UP * 832

#tiles/sec
export var speed = .25

#ease instead of jerk platform
var follow = Vector2.ZERO


onready var tween = $lvl_1_moving_lava_tween

func _ready():
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 128)
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.start()

func _physics_process(delta):
	$lvl_1_moving_lava_body.position = $lvl_1_moving_lava_body.position.linear_interpolate(follow, 0.075)
