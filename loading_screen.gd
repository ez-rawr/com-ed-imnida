extends Control

@onready var loading_animation = $AnimatedSprite2D

func _ready():
	loading_animation.play("loading")  # Start playing the loading animation
	
	# Start loading the scene asynchronously
	ResourceLoader.load_threaded_request(Globals.next_scene_path)
	
	# Wait for 5 seconds before transitioning
	await get_tree().create_timer(5.0).timeout  

	# Ensure the scene is fully loaded before switching
	while ResourceLoader.load_threaded_get_status(Globals.next_scene_path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame

	# Change to the loaded scene
	var new_scene = ResourceLoader.load_threaded_get(Globals.next_scene_path)
	get_tree().change_scene_to_packed(new_scene)
