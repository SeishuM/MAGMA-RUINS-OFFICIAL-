extends Control

func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/Pause.grab_focus()

func _physics_process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/Pause.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/Pause.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/Quit.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/Quit.grab_focus()
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$MarginContainer/CenterContainer/VBoxContainer/Pause.grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_Pause_pressed():
		get_tree().paused = not get_tree().paused
		visible = not visible


func _on_Quit_pressed():
	get_tree().quit()
