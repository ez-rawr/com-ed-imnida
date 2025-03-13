# Character.gd
extends CharacterBody2D

# Speed of the character
@export var speed: float = 100.0
@export var sprint_speed: float = 150.0

# Reference to the AnimatedSprite2D node
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Physics process function to handle movement and animation
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Get input direction
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	var current_speed = speed
	if Input.is_action_pressed("ui_end"):
		current_speed = sprint_speed

	# If there's input, move and animate the character
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
		if direction.y < 0:
			animated_sprite.play("walk_up")
		elif direction.y > 0:
			animated_sprite.play("walk_down")
		elif direction.x < 0:
			animated_sprite.play("walk_left")
		elif direction.x > 0:
			animated_sprite.play("walk_right")
	else:
		velocity = Vector2.ZERO
		# Play idle animation based on the last walking direction
		match animated_sprite.animation:
			"walk_up":
				animated_sprite.play("idle_up")
			"walk_down":
				animated_sprite.play("idle_down")
			"walk_left":
				animated_sprite.play("idle_left")
			"walk_right":
				animated_sprite.play("idle_right")
	
	# Apply movement and handle collision
	move_and_slide()
