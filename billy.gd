extends CharacterBody2D

var player_in_area = false

@onready var npc_idle = $npc_idle            # NPC's idle animation
@onready var key_prompt = $key_prompt        # Key prompt animation
@onready var click_sound = $AudioStreamPlayer # Click sound

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		click_sound.play()      # Play click sound
		key_prompt.visible = false  # Hide the key prompt
		run_dialogue("dialogue1")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		key_prompt.visible = true
		key_prompt.play("idle")  # Show and animate the key prompt

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		key_prompt.visible = false  # Hide the key prompt when player leaves
