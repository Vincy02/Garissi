extends Node

const scene_test = preload("res://Scenes/test.tscn")
const scene_park = preload("res://Scenes/park.tscn")

var spawn_door_tag 

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"test":
			scene_to_load = scene_test
		"park":
			scene_to_load = scene_park
	
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
