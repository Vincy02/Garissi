extends Node

@onready var park = "res://Scenes/park.tscn"

func _start_game() -> void:
	#TransitionScreen.transition()
	#await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Missions/firstMission.tscn")
	Player.set_player_position(Vector2(1316, 740), "right")
	
