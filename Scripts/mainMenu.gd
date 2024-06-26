class_name MainMenu
extends Control


@onready var start_button = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/newGame as Button
@onready var options_button = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/options as Button
@onready var exit_button = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/exit as Button
@onready var keybinds_button = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/keybinds as Button
@onready var back_button = $Back as Button
@onready var settings_menu = $SettingsMenu
@onready var keybinds_menu = $KeybindsMenu

func _ready():
	back_button.button_down.connect(_on_back_button_pressed)
	keybinds_button.button_down.connect(_on_commands_button_pressed)
	start_button.button_down.connect(_on_start_button_pressed)
	options_button.button_down.connect(_on_options_button_pressed)
	exit_button.button_down.connect(_on_exit_button_pressed)
	settings_menu.visible = false
	keybinds_menu.visible = false
	back_button.visible = false
	
func _on_start_button_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	ScenesManager._start_game()

func _on_options_button_pressed() -> void:
	settings_menu.visible = true
	back_button.visible = true

func _on_commands_button_pressed() -> void:
	keybinds_menu.visible = true
	back_button.visible = true

func _on_back_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _unhandled_input(event):
	if Input.is_action_just_pressed("Pause") && settings_menu.is_visible_in_tree():
		settings_menu.visible = false
		back_button.visible = false
	if Input.is_action_just_pressed("Pause") && keybinds_menu.is_visible_in_tree():
		keybinds_menu.visible = false
		back_button.visible = false
