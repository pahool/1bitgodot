extends CharacterBody2D

const DustEffectScene = preload("res://effects/dust_effect.tscn")

@export var acceleration = 512
@export var max_velocity = 64
@export var friction = 256
@export var gravity = 200
@export var jump_force = 128
@export var max_fall_velocity = 128
@onready var player_blaster = $PlayerBlaster

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var fire_rate_timer = $FireRateTimer

func _physics_process(delta):
	
	apply_gravity(delta)
	var input_axis = Input.get_axis("move_left", "move_right")
	if is_moving(input_axis):
		apply_acceleration(delta, input_axis)
	else: 
		apply_friction(delta)
	jump_check()
	if Input.is_action_pressed("fire") and fire_rate_timer.time_left == 0:
		fire_rate_timer.start()
		player_blaster.fire_bullet()
	if Input.is_action_just_pressed("crouch"):
		set_collision_mask_value(2, false)
	if Input.is_action_just_released("crouch"):
		set_collision_mask_value(2, true)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_edge:
		coyote_jump_timer.start()
	
func create_dust_effect():
	Utils.instantiate_scene_on_world(DustEffectScene, global_position)

func is_moving(input_axis):
	return input_axis != 0

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta)
		
func apply_acceleration(delta, input_axis):
	velocity.x = move_toward(velocity.x, input_axis * max_velocity, acceleration * delta)

func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, friction * delta)
		
func jump_check():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_force
	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < -jump_force / 2:
			velocity.y = -jump_force / 2

func update_animations(input_axis):
	# character should face mouse (and handle 0 case for mouse position)
	sprite_2d.scale.x = sign(get_local_mouse_position().x)
	if abs(sprite_2d.scale.x) != 1: sprite_2d.scale.x = 1 
	
	if is_moving(input_axis):
		animation_player.play("run")
		# reverse animation if running backwards
		animation_player.speed_scale = input_axis * sprite_2d.scale.x
	else: animation_player.play("idle")
	
	if not is_on_floor():
		animation_player.play("jump")
