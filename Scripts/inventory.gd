extends Control

@onready var button_left = $MarginContainer/Container/ButtonLeft/TextureButton
@onready var button_right = $MarginContainer/Container/ButtonRight/TextureButton
@onready var image_item = $MarginContainer/Container/Item/Container/Image
@onready var name_item = $MarginContainer/Container/Item/Container/DescriptionContainer/Name
@onready var desc_item = $MarginContainer/Container/Item/Container/DescriptionContainer/Description
@onready var inventory
@onready var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	button_left.button_down.connect(_on_button_left_down)
	button_right.button_down.connect(_on_button_right_down)
	inventory = InventoryManager.get_invetory()
	load_item(index)
	
func update_inventory():
	inventory = InventoryManager.get_invetory()
	check()
	load_item(index)

func _on_button_left_down():
	index -= 1
	check()
	load_item(index)
	
func _on_button_right_down():
	index += 1
	check()
	load_item(index)

func check() -> void:
	if index < 0:
		index = inventory.size() - 1
	if index >= inventory.size():
		index = 0

func load_item(_index: int):
	if inventory.size() > 0 && _index < inventory.size():
		name_item.text = inventory[_index]["NAME"]
		desc_item.text = inventory[_index]["DESCRIPTION"]
		image_item.texture = load("res://Sprites/Items/" + inventory[_index]["FILE NAME"] + ".png")
	if inventory.size() == 0:
		name_item.text = ""
		desc_item.text = ""
		image_item.texture = load("res://Sprites/Items/emptyItem.png")
