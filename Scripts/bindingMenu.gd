class_name BindingMenu
extends Control

@onready var input_button_scene = preload("res://Scenes/BindingMenu/inputButton.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList
@onready var pause_menu = $"."

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"MoveUp": "Vai sù",
	"MoveDown": "Vai giù",
	"MoveLeft": "Vai a sinistra",
	"MoveRight": "Vai a destra",
	"Interact": "Interagisci"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_keybind_from_settings()
	_create_action_list()

func _load_keybind_from_settings():
	var keybinds = SettingsManager.load_keybinds_settings()
	for action in keybinds.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keybinds[action])

func _create_action_list():
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button_scene.instantiate()	
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		_set_action_label(input_label, action)
			
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		remapping_button = button
		action_to_remap = action
		button.find_child("LabelInput").text = "Premi per cambiare tasto..."

func _input(event):
	if is_remapping:
		if (event is InputEventKey || (event is InputEventMouseButton && event.pressed)):
			
			# Turn double click into single click
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			# Handling ESCAPE binding
			if !Input.is_action_just_pressed("Pause"):
				var event_to_remap = InputMap.action_get_events(action_to_remap)[0]
				InputMap.action_erase_events(action_to_remap)
					
				# Remove dupllicate inputs from previously assigned actions
				for action in input_actions:
					if InputMap.action_has_event(action, event):
						InputMap.action_erase_event(action, event)
						InputMap.action_add_event(action, event_to_remap)
						var buttons_with_action = action_list.get_children().filter(func(button):
							return button.find_child("LabelAction").text == input_actions[action]
						)
						for button in buttons_with_action:
							button.find_child("LabelInput").text = event_to_remap.as_text().trim_suffix(" (Physical)")
							
				InputMap.action_add_event(action_to_remap, event)
				SettingsManager.save_keybinds_settings(action_to_remap, event)
				_update_action_list(remapping_button, event)
			else:
				_set_action_label(remapping_button.find_child("LabelInput"), action_to_remap)
				
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			# Allows to bind a mouse click safely	
			accept_event()
			
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
	
func _on_reset_button_pressed():
	InputMap.load_from_project_settings()
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			SettingsManager.save_keybinds_settings(action, events[0])
	_create_action_list()

func _set_action_label(label, action):
	var events = InputMap.action_get_events(action)
	if events.size() > 0:
		label.text = events[0].as_text().trim_suffix(" (Physical)")
	else:
		label.text = ""
