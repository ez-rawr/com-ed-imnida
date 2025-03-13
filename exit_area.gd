extends Area2D

signal player_near_exit(near_exit)

func _ready():
	# Connect the signals to the functions
	connect("body_entered", self, "_on_Area2D_body_entered")
	connect("body_exited", self, "_on_Area2D_body_exited")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("player_near_exit", true)

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		emit_signal("player_near_exit", false)
