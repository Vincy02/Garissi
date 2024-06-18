class_name MainMenu
extends Control

@onready var startButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/newGame as Button
@onready var optionsButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/options as Button
@onready var exitButton = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/exit as Button
@onready var startLevel = preload("res://Scenes/square.tscn") as PackedScene


func _ready():
	startButton.button_down.connect(on_start_button_pressed)
	optionsButton.button_down.connect(on_options_button_pressed)
	exitButton.button_down.connect(on_exit_button_pressed)
	
func on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(startLevel)

func on_options_button_pressed() -> void:
	pass
	
func on_exit_button_pressed() -> void:
	get_tree().quit()
