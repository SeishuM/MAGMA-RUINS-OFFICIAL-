# MainMenu.gd
extends Control

func _on_StartGame_pressed():
	get_tree().change_scene("res://Level 1.tscn")

func _on_QuitGame_pressed():
	get_tree().quit()

func _ready():
	var audio = AudioStreamPlayer.new()
	self.add_child(audio)
	audio.stream = load("res://audio-theme.ogg")
	audio.play()