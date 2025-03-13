extends Node

@onready var move_instructions = $"../UI/MoveInstructions"  # Adjust path if needed
@onready var anim_player = $"AnimationPlayer"

func _ready():
	move_instructions.visible = false  # Hide instructions at start
	Dialogic.signal_event.connect(_on_dialogue_event)  # Listen for events from Dialogic

func _on_dialogue_event(event_name: String):
	if event_name == "show_move_instructions":
		move_instructions.visible = true  # Show the instructions
		await get_tree().create_timer(5).timeout  # Wait for 5 seconds
		anim_player.play("fade_out")  # Play fade-out animation
		await anim_player.animation_finished  # Wait for animation to finish
		move_instructions.visible = false  # Hide completely
