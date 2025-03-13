extends CanvasLayer

# Function to handle the button press
func _on_Button_pressed():
	# Hide the prompt
	self.hide()
	
	# Start the dialogue manager (replace with your dialogue manager start code)
	get_tree().change_scene("res://path_to_your_world_scene.tscn")
