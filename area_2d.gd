extends Area2D

var player_in_area = false

@onready var key_prompt1 = $key_prompt1  # Assuming you renamed it
@onready var click_sound = $AudioStreamPlayer

func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("ui_accept"):
			key_prompt1.play("pressed")
			click_sound.play()  # Play sound on key press
			await get_tree().create_timer(0.2).timeout  # Wait for the press animation
			Globals.next_scene_path = "res://lv1draft.tscn"
			get_tree().change_scene_to_file("res://loading_screen.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		key_prompt1.visible = true
		key_prompt1.play("idle")  # Play the idle animation when in range

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		key_prompt1.visible = false
