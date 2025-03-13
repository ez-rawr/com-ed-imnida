extends Control

@onready var button_sound = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_button_pressed() -> void:
	button_sound.play()  
	get_tree().change_scene_to_file("res://lv1_tiles.tscn")
