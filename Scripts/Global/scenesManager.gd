extends Node

var current_mission = 0
var current_scene
var prova

func _start_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/Missions/intro.tscn")

func _ready():
	pass
	
func _process(delta):
	pass

func mission_completed() -> void:
	current_mission += 1
	start_mission()
	
func start_mission() -> void:
	match current_mission:
		1:
			FirstMission.start()
			

func set_current_scene(scene) -> void:
	current_scene = scene 
	print(scene)
