extends Control

@onready var input_button_scene = preload("res://Scenes/InputSettings/inputButton.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null
@onready var pause_menu = $"."

var input_actions = {
	"MoveUp": "Move up",
	"MoveDown": "Move down",
	"MoveLeft": "Move left",
	"MoveRight": "Move right",
	"Interact": "Interact"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_create_action_list()
	pause_menu.visible = false
	pass # Replace with function body.

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button_scene.instantiate()	
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if !get_tree().paused:
			get_tree().paused = true
			pause_menu.visible = true
		else:
			get_tree().paused = false
			pause_menu.visible = false
