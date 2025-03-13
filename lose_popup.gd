extends Control

func _ready():
	# Hide the popup initially
	visible = false

func show_popup():
	# Show the "You Lose" popup
	visible = true

func _on_button_pressed() -> void:
	Globals.next_scene_path = "res://lv1draft.tscn"
	get_tree().change_scene_to_file("res://loading_screen.tscn")

func _on_button_2_pressed() -> void:
	Globals.next_scene_path = "res://inside_house.tscn"
	get_tree().change_scene_to_file("res://loading_screen.tscn")
