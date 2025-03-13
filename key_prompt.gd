extends Area2D

signal player_near_door(near_door)

func _ready():
	# Correctly connect the signals to the respective methods
	connect("body_entered", self, "_on_Area2D_body_entered")
	connect("body_exited", self, "_on_Area2D_body_exited")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):  # Ensure only the player triggers the signa	
		emit_signal("player_near_door", true)

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):  # Ensure only the player triggers the signal
		emit_signal("player_near_door", false)
