extends Area2D

var tiles = []
var solved = []
var mouse = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game():
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, $Tile9]
	solved = tiles.duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse:
		var _mouse_copy = mouse
		print(mouse.position)
		mouse = false
		var _rows = int(_mouse_copy.position.y / 160)
		var _cols = int(_mouse_copy.position.x / 265)
		check_neighbours(_rows, _cols)

func check_neighbours(_rows, _cols):
	var num_cols = 3  # Number of columns in your grid
	var num_rows = 3  # Number of rows in your grid
	
	# Check for valid row and column before proceeding
	if _rows < 0 or _rows >= num_rows or _cols < 0 or _cols >= num_cols:
		return
	
	var empty = false 
	var done = false 
	var _pos = _rows * num_cols + _cols
	
	# Check if _pos is a valid index
	if _pos < 0 or _pos >= tiles.size():
		return
	
	while !empty and !done:
		var new_pos = tiles[_pos].position
		
		# Check below
		if _rows < num_rows - 1:
			new_pos.y += 160
			empty = find_empty(new_pos, _pos)
			new_pos.y -= 160
		
		# Check above
		if _rows > 0:
			new_pos.y -= 160
			empty = find_empty(new_pos, _pos)
			new_pos.y += 160
		
		# Check right
		if _cols < num_cols - 1:
			new_pos.x += 265
			empty = find_empty(new_pos, _pos)
			new_pos.x -= 265
		
		# Check left
		if _cols > 0:
			new_pos.x -= 265
			empty = find_empty(new_pos, _pos)
			new_pos.x += 265
		
		done = true



func find_empty(_position,_pos):
	var new_rows = int(position.y / 265)
	var new_cols = int(position.x / 160)
	var new_pos = new_rows * 3 + new_cols
	if tiles[new_pos] == $Tile9:
		sawap_tiles(_pos, new_pos)
		return true
	else:
		return false

func sawap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var _temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = _temp_tile

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		mouse = event
