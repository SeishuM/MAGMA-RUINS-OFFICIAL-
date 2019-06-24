extends Node2D

func _ready():
	var audio = AudioStreamPlayer.new()
	self.add_child(audio)
	audio.stream = load("res://audio-theme.ogg")
	audio.play()