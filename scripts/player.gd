extends CharacterBody2D


@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO


func _physics_process(delta):
	var input_vector = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if input_vector == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(input_vector * ACCELERATION * delta)
	move_and_slide()

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
