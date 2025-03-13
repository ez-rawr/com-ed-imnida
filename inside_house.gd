extends TileMap

@onready var dialogic = Dialogic

func _ready():
	if Globals.next_dialogue != "":
		dialogic.start(Globals.next_dialogue)
