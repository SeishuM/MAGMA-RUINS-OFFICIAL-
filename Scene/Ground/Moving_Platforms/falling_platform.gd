extends Area2D

#how long platform pauses at either end
const IDLE_DURATION = 0.5

#how far platform travels (use multiple of 32)
export var move_to = Vector2.DOWN * 320

#tiles/sec
export var speed = 5.0


onready var tween = $Tween

func _ready():
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 128)
	tween.interpolate_property(self, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)

func _on_falling_platform_area_entered(area):
	if area.get_name() == "Player":
		$Tween.start()
	pass # Replace with function body.
