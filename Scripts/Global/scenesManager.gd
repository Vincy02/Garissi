extends Node

@onready var square = preload("res://Scenes/square.tscn") as PackedScene

func _start_game() -> void:
	get_tree().change_scene_to_packed(square)
	Player.set_player_position(Vector2(1316, 740), "left")
	
