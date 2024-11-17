extends CharacterBody2D


@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO

#used for generating a random powerup
var rng = RandomNumberGenerator.new()


#need to adjust to bounce back
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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_in_group("powerups"):
		var powerUpNumber = round(rng.randf_range(0, 2))
		print(powerUpNumber)
		
		powerUpNumber = 0
		
		if powerUpNumber == 0:
			print("speed up!")
			var temp = MAX_SPEED
			MAX_SPEED = MAX_SPEED * 2
			await get_tree().create_timer(5.0).timeout
			MAX_SPEED = temp
		elif powerUpNumber == 1:
			print("faster bullets!")
		else:
			print("bullet spread!")
