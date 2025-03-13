extends Area2D

var tiles = []
var solved = []
var mouse = false
var label = Label
var time = Timer

@onready var tile9 = $Tile9
@onready var timer = $Timer
@onready var winpopup = $WinPopup # Adjust path if necessary
@onready var losepopup = $LosePopup
@onready var move_sound = $MovingSound
@onready var bg_music  = $BGMusic

func _ready() -> void:
	start_game()
	label = $Label
	time = $"."
	
	timer.start()
	bg_music.play() 
	losepopup.visible = false  # Hide the "You Lose" popup initially

func update_label_text():
	label.text = str(ceil(timer.time_left))
	var time_left = int(timer.time_left)  # Get remaining time as an integer
	var minutes = time_left / 60  # Get minutes
	var seconds = time_left % 60  # Get remaining seconds

	label.text = "%02d:%02d" % [minutes, seconds]  # Format as MM:SS

func start_game():
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, $Tile9]
	solved = tiles.duplicate()
	shuffle_tiles()
	
func shuffle_tiles():
	var previous = 99
	var previous_1 = 98
	for t in range(0, 1000):
		var tile = randi() % 9
		if tiles[tile] != $Tile9 and tile != previous and tile != previous_1:
			var rows = int((tiles[tile].position.y - 79) / 160)
			var cols = int((tiles[tile].position.x - 177) / 265)
			check_neighbours(rows, cols)
			previous_1 = previous
			previous = tile

func _process(_delta: float) -> void:
	update_label_text()
	if tiles == solved:
		print("You win!")
		timer.stop()
		winpopup.visible = true  # Show "YOU WIN!" popup
		losepopup.visible = false  # Ensure "YOU LOSE" popup is hidden
		
	# Manually check if time runs out
	if timer.time_left <= 0 and not winpopup.visible:
		print("You lose!")
		timer.stop()
		losepopup.visible = true  # Show "YOU LOSE!" popup

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse:
		var _mouse_copy = mouse
		print(mouse.position)
		mouse = false
		var _rows = int((_mouse_copy.position.y - 79) / 160)
		var _cols = int((_mouse_copy.position.x - 177) / 265)
		check_neighbours(_rows, _cols)
		if tiles == solved:
			print("You win!")
			timer.stop()

func check_neighbours(_rows, _cols):
	var emptyrow = int((tile9.position.y - 79) / 160)
	var emptycol = int((tile9.position.x - 177) / 265)
	var emptypos = emptyrow * 3 + emptycol
	
	var empty = false 
	var done = false 
	var _pos = (_rows * 3 + _cols) 
	while not empty and not done:
		var _new_pos = tiles[_pos].position
		if (_rows == 0) and (_cols == 0):
			if (emptypos == 1) or (emptypos == 3):
				empty = find_empty(emptypos, _pos)	
				
		if (_rows == 2) and (_cols == 2):
			if (emptypos == 7) or (emptypos == 5):
				empty = find_empty(emptypos, _pos)	
				
		if (_rows == 2) and (_cols == 0):
			if (emptypos == 3) or (emptypos == 7):
				empty = find_empty(emptypos, _pos)	
				
		if (_rows == 0) and (_cols == 2):
			if (emptypos == 1) or (emptypos == 5):
				empty = find_empty(emptypos, _pos)	
				
		if (_rows == 0) and (_cols == 1):
			if (emptypos == 0) or (emptypos == 2) or (emptypos == 4):
				empty = find_empty(emptypos, _pos)		
					
		if (_rows == 1) and (_cols == 0):
			if (emptypos == 0) or (emptypos == 6) or (emptypos == 4):
				empty = find_empty(emptypos, _pos)		
					
		if (_rows == 1) and (_cols == 2):
			if (emptypos == 2) or (emptypos == 8) or (emptypos == 4):
				empty = find_empty(emptypos, _pos)	
					
		if (_rows == 2) and (_cols == 1):
			if (emptypos == 8) or (emptypos == 6) or (emptypos == 4):
				empty = find_empty(emptypos, _pos)	
				
		if (_rows == 1) and (_cols == 1):
			if (emptypos == 1) or (emptypos == 3) or (emptypos == 5) or (emptypos == 7):
				empty = find_empty(emptypos, _pos)	
					
		done = true

func find_empty(index, _pos):
	if tiles[index] == $Tile9:
		swap_tiles(_pos, index)
		print("hihi")
		return true
	else:
		return false

func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var _temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = _temp_tile
	
	move_sound.play()  # Play sound when tile moves

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		mouse = event

func _on_button_pressed() -> void:
	shuffle_tiles()

func _on_timer_timeout() -> void:
	if not winpopup.visible:
		print("Timer timeout!")
		losepopup.visible = true  # Show "YOU LOSE!" popup


func _on_button_2_pressed() -> void:
		Globals.next_scene_path = "res://inside_house.tscn"
		get_tree().change_scene_to_file("res://loading_screen.tscn")
		Globals.next_dialogue = "ih"
