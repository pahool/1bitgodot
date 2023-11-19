extends Node2D

@onready var launch_animation = $LaunchAnimation
@onready var launch_button = $LaunchButton
@onready var rocket_flare = $Rocket/RocketFlare

func _ready():
	rocket_flare.hide()

func _on_launch_button_button_down():
	rocket_flare.show()
	launch_animation.play("launch")
	launch_button.hide()
