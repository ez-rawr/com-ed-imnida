extends CharacterBody2D

@export var speed: float = 100.0
@export var sprint_speed: float = 150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
	
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	var is_running = Input.is_action_pressed("ui_shift")  # Check if sprinting

	# Get input direction
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	var current_speed = sprint_speed if is_running else speed  # Set speed based on sprinting

	# If moving, apply movement and animation
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * current_speed
		move_and_slide()

		# Play running or walking animations based on movement direction
		if direction.y < 0:
			animated_sprite.play("run_up" if is_running else "walk_up")
		elif direction.y > 0:
			animated_sprite.play("run_down" if is_running else "walk_down")
		elif direction.x < 0:
			animated_sprite.play("run_left" if is_running else "walk_left")
		elif direction.x > 0:
			animated_sprite.play("run_right" if is_running else "walk_right")
	else:
		velocity = Vector2.ZERO
		# Play idle animation based on last movement direction
		match animated_sprite.animation:
			"walk_up", "run_up":
				animated_sprite.play("idle_up")
			"walk_down", "run_down":
				animated_sprite.play("idle_down")
			"walk_left", "run_left":
				animated_sprite.play("idle_left")
			"walk_right", "run_right":
				animated_sprite.play("idle_right")
				
func player():
	pass

	
