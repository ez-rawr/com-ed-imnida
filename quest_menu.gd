extends Control

@onready var quest_menu : PackedScene = preload("res://quest_menu.tscn")

func _ready():
	$Panel/CloseMenu.connect("pressed", _on_close_pressed)

func _on_close_pressed():
	queue_free()  # Removes the quest menu when closed
