extends Node

@onready var park = "res://Scenes/park.tscn"

func _start_game() -> void:
	get_tree().change_scene_to_file(park)
	Player.set_player_position(Vector2(1316, 740), "right")
	
