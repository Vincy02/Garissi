extends Node

func _start_game() -> void:
	#TransitionScreen.transition()
	#await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Missions/firstMission.tscn")
	
