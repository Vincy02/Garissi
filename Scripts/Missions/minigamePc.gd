extends Node2D

@onready var puzzle = $TextureRect/MarginContainer/Control/GridContainer

var path = "res://Scenes/headOffice.tscn"
var is_exiting = false

signal minigame_pc_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("minigame_pc_completed", Callable(FifthMission, "minigame_completed"))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_puzzle():
	if is_puzzle_completed():
		emit_signal("minigame_pc_completed")
		back_to_head_office()
		
func back_to_head_office():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(path)
	
func is_puzzle_completed():
	var last_index = 0
	for tail in puzzle.get_children():
		if tail is TextureButton:
			if (tail.texture_normal != null) && (tail.rotation_degrees == 0):
				var current_index = int(tail.texture_normal.get_path().split("tail")[2].trim_suffix(".png"))
				if last_index < current_index:
					last_index = current_index
					continue
				else:
					return false
			else:
				return false
				
	return true

func _input(event):
	if Input.is_action_just_pressed("Pause") && !is_exiting:
		is_exiting = true
		back_to_head_office()
