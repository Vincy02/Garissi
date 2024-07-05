class_name PauseMenu
extends Control

@onready var main_menu = preload("res://Scenes/MainMenu/mainMenu.tscn") as PackedScene
@onready var pause_menu = $"."
@onready var keybinds_menu = $KeybindsMenu
@onready var settings_menu = $SettingsMenu
@onready var inventory = $Inventory
@onready var panel_container_pause_menu = $PanelContainer
@onready var continue_button = $PanelContainer/MarginContainer/VBoxContainer/continueGame as Button
@onready var options_button = $PanelContainer/MarginContainer/VBoxContainer/options as Button
@onready var commands_button = $PanelContainer/MarginContainer/VBoxContainer/keybinds as Button
@onready var exit_button = $PanelContainer/MarginContainer/VBoxContainer/exit as Button
@onready var back_button = $Back as Button
static var work = true

# Called when the node enters the scene tree for the first time. 
func _ready():
	continue_button.button_down.connect(on_continue_button_pressed)
	options_button.button_down.connect(on_options_button_pressed)
	commands_button.button_down.connect(on_commands_button_pressed)
	exit_button.button_down.connect(on_exit_button_pressed)
	back_button.button_down.connect(on_back_button_pressed)
	pause_menu.visible = false
	settings_menu.visible = false
	keybinds_menu.visible = false
	inventory.visible = false
	back_button.visible = false

func on_continue_button_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false

func on_options_button_pressed() -> void:
	settings_menu.visible = true
	back_button.visible = true
	disable_all()

func on_back_button_pressed() -> void:
	back_to_pause_menu()

func on_commands_button_pressed() -> void:
	keybinds_menu.visible = true
	back_button.visible = true
	disable_all()

func back_to_pause_menu() -> void:
	keybinds_menu.visible = false
	settings_menu.visible = false
	back_button.visible = false
	rienable_all()

func on_exit_button_pressed() -> void:
	get_tree().paused = false
	ScenesManager.reset_scenes()
	get_tree().change_scene_to_packed(main_menu)

func disable_all() -> void:
	panel_container_pause_menu.visible = false
	
func rienable_all() -> void:
	panel_container_pause_menu.visible = true

static func resume_working() -> void:
	work = true

static func stop_working() -> void:
	work = false
			
func _unhandled_input(event):
	if work:
		if Input.is_action_just_pressed("Pause") && !keybinds_menu.is_visible_in_tree() && !settings_menu.is_visible_in_tree() && !inventory.is_visible_in_tree():
			if !get_tree().paused:
				get_tree().paused = true
				pause_menu.visible = true
			else:
				get_tree().paused = false
				pause_menu.visible = false
		else:
			if Input.is_action_just_pressed("Pause") && (keybinds_menu.is_visible_in_tree() || settings_menu.is_visible_in_tree()) && !inventory.is_visible_in_tree():
				back_to_pause_menu()
		
		#gestione dell'inventario
		if Input.is_action_just_pressed("Inventory") && !keybinds_menu.is_visible_in_tree() && !settings_menu.is_visible_in_tree():
			if !get_tree().paused:
				get_tree().paused = true
				pause_menu.visible = true
				inventory.visible = true
		else:
			if Input.is_action_just_pressed("Pause") && inventory.is_visible_in_tree():
				if get_tree().paused:
					get_tree().paused = false
					pause_menu.visible = false
					inventory.visible = false
				
