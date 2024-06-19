class_name PauseMenu
extends Control

@onready var pauseMenu = $"."
@onready var inputSettings = $InputSettings
@onready var settingsMenu = $SettingsMenu
@onready var panelConteinerPauseMenu = $PanelContainer
@onready var continueButton = $PanelContainer/MarginContainer/VBoxContainer/continueGame as Button
@onready var optionsButton = $PanelContainer/MarginContainer/VBoxContainer/options as Button
@onready var commandsButton = $PanelContainer/MarginContainer/VBoxContainer/commands as Button
@onready var exitButton = $PanelContainer/MarginContainer/VBoxContainer/exit as Button
@onready var backButton = $Back as Button
@onready var mainMenu = preload("res://Scenes/MainMenu/mainMenu.tscn") as PackedScene

# Called when the node enters the scene tree for the first time. 
func _ready():
	continueButton.button_down.connect(on_continue_button_pressed)
	optionsButton.button_down.connect(on_options_button_pressed)
	commandsButton.button_down.connect(on_commands_button_pressed)
	exitButton.button_down.connect(on_exit_button_pressed)
	backButton.button_down.connect(on_back_button_pressed)
	pauseMenu.visible = false
	settingsMenu.visible = false
	inputSettings.visible = false
	backButton.visible = false

func on_continue_button_pressed() -> void:
	get_tree().paused = false
	pauseMenu.visible = false

func on_options_button_pressed() -> void:
	settingsMenu.visible = true
	backButton.visible = true
	disable_all()

func on_back_button_pressed() -> void:
	back_to_pause_menu()

func on_commands_button_pressed() -> void:
	inputSettings.visible = true
	backButton.visible = true
	disable_all()

func back_to_pause_menu() -> void:
	inputSettings.visible = false
	settingsMenu.visible = false
	backButton.visible = false
	rienable_all()

func on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(mainMenu)

func disable_all() -> void:
	panelConteinerPauseMenu.visible = false
	
func rienable_all() -> void:
	panelConteinerPauseMenu.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause") && !inputSettings.is_visible_in_tree():
		if !get_tree().paused:
			get_tree().paused = true
			pauseMenu.visible = true
		else:
			get_tree().paused = false
			pauseMenu.visible = false
	else:
		if Input.is_action_just_pressed("Pause") && inputSettings.is_visible_in_tree():
			back_to_pause_menu()
