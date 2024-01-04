extends Node2D

const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")

enum DIRECTION {LEFT = -1, RIGHT = 1}

@export var crawling_direction = DIRECTION.RIGHT
@export var max_speed = 150

@onready var floor_cast = $FloorCast
@onready var wall_cast = $WallCast
@onready var stats = $Stats as Stats

func _ready():
	wall_cast.target_position.x *= crawling_direction

func _physics_process(delta):
	if wall_cast.is_colliding():
		global_position = wall_cast.get_collision_point()
		var wall_normal = wall_cast.get_collision_normal() as Vector2
		rotation = wall_normal.rotated(deg_to_rad(90)).angle()
	else:
		floor_cast.rotation_degrees = -max_speed * crawling_direction * delta
		if floor_cast.is_colliding():
			global_position = floor_cast.get_collision_point()
			var floor_normal = floor_cast.get_collision_normal() as Vector2
			rotation = floor_normal.rotated(deg_to_rad(90)).angle()
		else:
			rotation_degrees += crawling_direction * 2
	
func _on_hurt_box_hurt(hitbox, damage):
	stats.health -= damage


func _on_stats_no_health():
	Utils.instantiate_scene_on_world(EnemyDeathEffectScene, global_position)
	queue_free()
