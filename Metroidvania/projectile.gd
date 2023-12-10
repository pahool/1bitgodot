extends Node2D

@export var speed = 250

var velocity = Vector2.ZERO

func _ready():
	velocity.x = speed
	velocity.rotated(rotation)

func _process(delta):
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
