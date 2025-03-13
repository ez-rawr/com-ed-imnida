extends Control

var is_chatting = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func _on_start_button_pressed() -> void:
	print("Start pressed")
	$mainmenu_hover/mainmenu_click.play()
	Globals.next_scene_path = "res://Prototype.tscn"
	get_tree().change_scene_to_file("res://loading_screen.tscn")
	Globals.next_dialogue = "opening scene"

func _on_settings_button_pressed() -> void:
	print("Settings Pressed")
	$mainmenu_hover/mainmenu_click.play()
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_exit_button_pressed() -> void:
	print("Exit Pressed")
	get_tree().quit()
	$mainmenu_hover/mainmenu_click.play()


func _on_start_button_mouse_entered() -> void:
	$mainmenu_hover.play()


func _on_settings_button_mouse_entered() -> void:
	$mainmenu_hover.play()


func _on_exit_button_mouse_entered() -> void:
	$mainmenu_hover.play()
	
func run_dialogue(dialogue_string):
	is_chatting = true
	Dialogic.start(dialogue_string)
