class_name Level
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ScenesManager.set_current_scene(self)
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
func _process(delta):
	pass
	
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
	# Flush spawn door tag to prevent recall errors
	NavigationManager.spawn_door_tag = null
