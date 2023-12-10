extends Node2D

const BulletScene = preload("res://player/bullet.tscn")

@onready var blaster_sprite = $BlasterSprite
@onready var muzzle = $BlasterSprite/Muzzle

func _process(delta):
	blaster_sprite.rotation = get_local_mouse_position().angle()
	print(rad_to_deg(blaster_sprite.rotation))

func fire_bullet():
	var bullet = BulletScene.instantiate()
	var world = get_tree().current_scene
	world.add_child(bullet)
	bullet.rotation = blaster_sprite.rotation
	bullet.global_position = muzzle.global_position
