class_name Office
extends Node2D

var is_exiting = false
static var is_interacting = false
	
static func set_is_interacting(arg: bool):
	is_interacting = arg

func back_to_city_centre():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/cityCentre.tscn")
	
func _input(event):
	if Input.is_action_just_pressed("Pause") && !is_exiting && !is_interacting:
		is_exiting = true
		back_to_city_centre()
