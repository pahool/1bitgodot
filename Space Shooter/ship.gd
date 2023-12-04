extends Area2D

const LASER_SCENE = preload("res://laser.tscn")

@export var speed = 100
var height = ProjectSettings.get_setting("display/window/size/viewport_height")

# shipwidth is used to set boundaries so ship doesn't go off screen. May be better to use 
# may be better to use collision detection for this, but this is good enough.
var shipwidth = 16 

signal ship_destroyed

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		if position.y > shipwidth/2 :
			position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		if position.y < height - (shipwidth/2):
			position.y += speed * delta
	if Input.is_action_just_pressed("ui_accept"):
		var laser = LASER_SCENE.instantiate()
		var world = get_tree().current_scene
		world.add_child(laser)
		laser.position = position


func _on_area_entered(area):
	queue_free()
	area.queue_free()
	ship_destroyed.emit()
