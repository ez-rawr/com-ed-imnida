class_name Jasper extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"

@onready var Aniimation_Player : AnimationPlayer = $AnimationPlayer
@onready var down : Sprite2D = $Sprite2D

var move_speed : float = 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = direction * move_speed
	
	UpdateAnimation()
	
	pass
	
func _physics_process(delta):
	move_and_slide()
	
func SetDirection() -> bool:
	return true
	
func SetState() -> bool:
	return true
	
func UpdateAnimation() -> void:
	Aniimation_Player.play("idle_up")
	pass
	
	
