extends Button

@onready var quest_menu : PackedScene = preload("res://quest_menu.tscn")  # Preload the QuestMenu scene

func _ready():
	connect("pressed", _on_quest_button_pressed)

func _on_quest_button_pressed():
	var menu_instance = quest_menu.instantiate()  # Instantiate the scene
	get_tree().current_scene.add_child(menu_instance)  # Add the menu to the scene
