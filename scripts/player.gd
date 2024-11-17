extends CharacterBody2D


@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200
@export var BULLET_SPEED = 1000
@export var FIRE_RATE = 0.2
@export var LASER_RATE = 1

@onready var axis = Vector2.ZERO

var bullet = preload("res://scenes/bullet_player.tscn")
var laser = preload("res://scenes/laser_player.tscn")
var can_fire = true
var can_fire_laser = true

func _physics_process(delta):
	var input_vector = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var fire = Input.is_action_pressed("fireLeft")
	var fire_special = Input.is_action_pressed("fireRight")
	if input_vector == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(input_vector * ACCELERATION * delta)
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
	move_and_slide()

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func fire_bullet() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.transform = transform
	# bullet_instance.position = get_global_position()
	# bullet_instance.rotation = rotation_degrees
	bullet_instance.apply_impulse(Vector2(-1 * BULLET_SPEED, 0).rotated(rotation + deg_to_rad(180)))
	# bullet_instance.velocity += BULLET_SPEED
	get_tree().get_root().add_child(bullet_instance)

func fire_laser() -> void:
	var laser_instance = laser.instantiate()
	laser_instance.transform = transform
	#laser_instance.position = get_global_position()
	#laser_instance.rotation = rotation_degrees
	laser_instance.apply_impulse(Vector2(0, 0).rotated(rotation + deg_to_rad(180)))
	get_tree().get_root().add_child(laser_instance)

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
