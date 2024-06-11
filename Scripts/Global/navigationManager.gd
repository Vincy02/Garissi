extends Node

const scene_test = preload("res://Scenes/square.tscn")
const scene_park = preload("res://Scenes/park.tscn")

signal on_trigger_player_spawn

var spawn_door_tag 

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"test":
			scene_to_load = scene_test
		"park":
			scene_to_load = scene_park
	
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
