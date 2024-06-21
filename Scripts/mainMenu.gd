class_name MainMenu
extends Control

@onready var startButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/newGame as Button
@onready var optionsButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/options as Button
@onready var exitButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/exit as Button
@onready var commandsButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/commands as Button
@onready var backButton = $Back as Button
@onready var startLevel = preload("res://Scenes/square.tscn") as PackedScene
@onready var settingMenu = $SettingsMenu
@onready var bindingMenu = $BindingMenu

func _ready():
	settingMenu.visible = false
	bindingMenu.visible = false
	backButton.visible = false
	backButton.button_down.connect(on_back_button_pressed)
	commandsButton.button_down.connect(on_commands_button_pressed)
	startButton.button_down.connect(on_start_button_pressed)
	optionsButton.button_down.connect(on_options_button_pressed)
	exitButton.button_down.connect(on_exit_button_pressed)
	
func on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(startLevel)

func on_options_button_pressed() -> void:
	settingMenu.visible = true
	backButton.visible = true

func on_commands_button_pressed() -> void:
	bindingMenu.visible = true
	backButton.visible = true

func on_back_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func on_exit_button_pressed() -> void:
	get_tree().quit()

func _process(delta):
	pass

func _unhandled_input(event):
	if Input.is_action_just_pressed("Pause") && settingMenu.is_visible_in_tree():
		settingMenu.visible = false
		backButton.visible = false
	if Input.is_action_just_pressed("Pause") && bindingMenu.is_visible_in_tree():
		bindingMenu.visible = false
		backButton.visible = false
