extends Node

const scene_square = preload("res://Scenes/square.tscn")
const scene_park = preload("res://Scenes/park.tscn")
const scene_cityCentre = preload("res://Scenes/cityCentre.tscn")
const scene_barInside = preload("res://Scenes/barInside.tscn")
const scene_newsStandInside = preload("res://Scenes/newsStandInside.tscn")
const scene_upZone = preload("res://Scenes/upZone.tscn")
const scene_churchInside = preload("res://Scenes/churchInside.tscn")
signal on_trigger_player_spawn

var spawn_door_tag 

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"square":
			scene_to_load = scene_square
		"park":
			scene_to_load = scene_park
		"cityCentre":
			scene_to_load = scene_cityCentre		
		"barInside":
			scene_to_load = scene_barInside	
		"newsStandInside":
			scene_to_load = scene_newsStandInside	
		"upZone":
			scene_to_load = scene_upZone
		"churchInside":
			scene_to_load = scene_churchInside	
	
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
