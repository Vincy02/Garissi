extends Node

var items
var inventory = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var filePath = "res://Utils/items.json"
	var dataFile = FileAccess.open(filePath, FileAccess.READ)
	items = JSON.parse_string(dataFile.get_as_text())
	dataFile.close()

func add_item(arg: String):
	for item in items:
		if item["FILE NAME"] == arg:
			inventory.append(item)
			break

func remove_item(arg: String):
	for item in inventory:
		if item["FILE NAME"] == arg:
			inventory.erase(item) 
			break

func get_invetory():
	return inventory

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
