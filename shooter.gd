extends Node2D


@export var BULLET_SPEED = 1000
@export var FIRE_RATE = 0.2
@export var LASER_RATE = 1

@onready var axis = Vector2.ZERO

var bullet = preload("res://scenes/bullet_player.tscn")
var laser = preload("res://scenes/laser_player.tscn")
var can_fire = true
var can_fire_laser = true

func _physics_process(delta):
	var fire = Input.is_action_pressed("fireLeft")
	var fire_special = Input.is_action_pressed("fireRight")
	if fire and can_fire:
		fire_bullet()
		can_fire = false
		await get_tree().create_timer(FIRE_RATE).timeout
		can_fire = true
	if fire_special and can_fire_laser:
		fire_laser()
		can_fire_laser = false
		await get_tree().create_timer(LASER_RATE).timeout
		can_fire_laser = true
	
func fire_bullet() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.transform = transform
	# bullet_instance.position = get_global_position()
	# bullet_instance.rotation = rotation_degrees
	bullet_instance.apply_impulse(Vector2(-1 * BULLET_SPEED, 0).rotated(rotation))
	# bullet_instance.velocity += BULLET_SPEED
	get_tree().get_root().add_child(bullet_instance)

func fire_laser() -> void:
	var laser_instance = laser.instantiate()
	laser_instance.position = get_global_position()
	laser_instance.rotation = rotation_degrees
	laser_instance.apply_impulse(Vector2(0, 0).rotated(rotation))
	get_tree().get_root().add_child(laser_instance)
