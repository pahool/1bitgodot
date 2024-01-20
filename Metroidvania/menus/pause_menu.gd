extends ColorRect

var paused = false : 
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused
		print("paused: " + str(paused))
		print("pause menu visible: " + str(visible))
		if paused:
			Sound.play(Sound.pause, 1.0, -10.0)
		else:
			Sound.play(Sound.unpause, 1.0, -10.0)
		
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		paused = !paused

func _on_resume_button_pressed():
	paused = false
	Sound.play(Sound.click, 1.0, -10.0)

func _on_quit_button_pressed():
	get_tree().quit()

func _on_menu_button_pressed():
	WorldStash.data = {}
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")
