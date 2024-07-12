extends Node

var current_scene
var mission_name = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth"]

func get_current_scene() -> Node2D:
	return current_scene

func _start_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/Missions/intro.tscn")

func setup_current_scene(scene) -> void:
	current_scene = scene
	for node in mission_name:
		var mission = "/root/" + node + "Mission"
		get_tree().root.get_node(mission).update_world_status(current_scene)
		
func reset_scenes() -> void:
	for node in mission_name:
		var mission = "/root/" + node + "Mission"
		get_tree().root.get_node(mission).reset_scene()
		
func stop_movement_player_and_pause() -> void:
	Player.stop_player()
	CharacterDialoge.set_is_interacting(true)
	InteractiveItem.set_is_interacting(true)
	Office.set_is_interacting(true)
	PauseMenu.stop_working()
	
func resume_movement_player_and_pause() -> void:
	Player.resume_player()
	CharacterDialoge.set_is_interacting(false)
	InteractiveItem.set_is_interacting(false)
	Office.set_is_interacting(false)
	PauseMenu.resume_working()
