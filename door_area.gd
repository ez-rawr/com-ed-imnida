extends Area2D

var player_in_area = false

@onready var key_prompt = get_node("key_prompt")   
@onready var click_sound = $AudioStreamPlayer
	
func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("ui_accept"):
			key_prompt.play("pressed")
			click_sound.play()  # Play sound on key press
			await get_tree().create_timer(0.2).timeout  # Wait for the press animation
			Globals.next_scene_path = "res://inside_house.tscn"
			get_tree().change_scene_to_file("res://loading_screen.tscn")
			Globals.next_dialogue = "ih"


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		key_prompt.visible = true
		key_prompt.play("idle")  # Play the idle animation when in range

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		key_prompt.visible = false

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
