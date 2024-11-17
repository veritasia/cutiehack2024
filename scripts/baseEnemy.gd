extends CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Anyone here?")
	$AudioStreamPlayer2D.stream = load("res://assets/sfx/defeatEnemy.mp3")
	$AudioStreamPlayer2D.play()
	if body.is_in_group("player_projectile"):
		print("I AM A PROJECTILE ;3")
		queue_free()
