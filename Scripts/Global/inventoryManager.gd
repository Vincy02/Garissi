extends Node

@onready var items

# Called when the node enters the scene tree for the first time.
func _ready():
	var filePath = "res://Utils/items.json"
	var dataFile = FileAccess.open(filePath, FileAccess.READ)
	items = JSON.parse_string(dataFile.get_as_text())
	dataFile.close()
	
func get_invetory():
	return items

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
