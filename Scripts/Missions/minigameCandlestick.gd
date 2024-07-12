extends Node2D

var path = "res://Scenes/church.tscn"
var is_exiting = false
var path_off = "res://Sprites/Minigame/Mission6/offCandle.png"
var path_on = "res://Sprites/Minigame/Mission6/onCandle.png"

var status = [false, false, false, false, false, false]
var solution = [false, true, false, true, true, false]

signal minigame_candlestick_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("minigame_candlestick_completed", Callable(SixthMission, "minigame_completed"))
	for i in range(1,7):
		var button_name = "TextureRect/Control/Button" + str(i)
		var button_node = get_node(button_name)
		get_node(button_name).connect("pressed", Callable(self, "button_pressed").bind(i))
		
func button_pressed(index : int):
	var texture_name = "TextureRect/Control/TextureRect" + str(index)
	var texture_node = get_node(texture_name)
	if texture_node.texture.get_path() == path_off:
		texture_node.texture = load(path_on)
		status[index-1] = true
	else:
		texture_node.texture = load(path_off)
		status[index-1] = false
		
	if check_solution():
		emit_signal("minigame_candlestick_completed")
		back_to_church()
		
func back_to_church():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(path)
	
func check_solution():
	for i in solution.size():
		if solution[i] != status[i]:
			return false
	return true
	
func _input(event):
	if Input.is_action_just_pressed("Pause") && !is_exiting:
		is_exiting = true
		back_to_church()
