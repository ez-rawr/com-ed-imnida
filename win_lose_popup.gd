extends Control

@onready var win_lose_text = $WinLoseText
@onready var replay_button = $ReplayButton

# Function to show the pop-up
func show_result(is_win: bool):
	if is_win:
		win_lose_text.text = "YOU WIN!"
	else:
		win_lose_text.text = "YOU LOSE!"
	
	self.visible = true

func _on_button_pressed() -> void:
	Globals.next_scene_path = "res://inside_house.tscn"
	get_tree().change_scene_to_file("res://loading_screen.tscn")
	Globals.next_dialogue = "what next"
