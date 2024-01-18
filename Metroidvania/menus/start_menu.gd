extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	get_tree().change_scene_to_file("res://world.tscn")

func _on_load_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	print("load save game")

func _on_quit_button_pressed():
	get_tree().quit()
