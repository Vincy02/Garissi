extends Node

var current_scene
var mission_name = ["First"]

func get_current_scene() -> Node2D:
	return current_scene

func _start_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/Missions/intro.tscn")

func setup_current_scene(scene) -> void:
	current_scene = scene
	for node in mission_name:
		var mission = "/root/" + node + "Mission"
		get_tree().root.get_node(mission).update_world_status(current_scene)
