extends Node

const scene_square = preload("res://Scenes/square.tscn")
const scene_park = preload("res://Scenes/park.tscn")
const scene_cityCentre = preload("res://Scenes/cityCentre.tscn")
const scene_bar = preload("res://Scenes/bar.tscn")
const scene_newsStand = preload("res://Scenes/newsStand.tscn")
const scene_upZone = preload("res://Scenes/upZone.tscn")
const scene_church = preload("res://Scenes/church.tscn")
const scene_seaside = preload("res://Scenes/seaside.tscn")
const scene_postOffice = preload("res://Scenes/postOffice.tscn")
const scene_headOffice = preload("res://Scenes/headOffice.tscn")

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
		"bar":
			scene_to_load = scene_bar	
		"newsStand":
			scene_to_load = scene_newsStand	
		"upZone":
			scene_to_load = scene_upZone
		"church":
			scene_to_load = scene_church	
		"seaside":
			scene_to_load = scene_seaside
		"postOffice":
			scene_to_load = scene_postOffice
		"headOffice":
			scene_to_load = scene_headOffice
	
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
