extends Node2D

@export var waypoint_buffer_distance = 8

var waypoints = []
var target: Node2D
var pathfinding_next_position: Vector2

@onready var ray_cast_2d = $RayCast2D

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if not MainInstances.player is Node2D: return
	target = MainInstances.player.center
	#if not target is Node2D: return
	
	if can_see_target(global_position):
		pathfinding_next_position = target.global_position
		waypoints.clear()
	else: 
		if not waypoints.is_empty():
			pathfinding_next_position = waypoints.front()
			
			if not can_see_target(waypoints.back()):
				waypoints.append(target.global_position)
				
			if global_position.distance_to(waypoints.front()) <= waypoint_buffer_distance:
				waypoints.pop_front()
		
		else: 
			if not can_see_target(global_position):
				waypoints.append(target.global_position)
			

func can_see_target(from):
	ray_cast_2d.global_position = from
	ray_cast_2d.target_position = target.global_position - from # makes raycast point to target
	ray_cast_2d.force_raycast_update()
	return not ray_cast_2d.is_colliding()

func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	set_physics_process(true)
