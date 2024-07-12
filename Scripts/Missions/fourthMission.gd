extends Node

var is_mission_completed = true
var first_time_entering = true
var current_scene

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "bring_to_office":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/office.tscn")
		Dialogic.start("gaiaOfficeTimeline1")
	if arg == "exit_office":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/cityCentre.tscn")
		is_mission_completed = true

func check_progession() -> void:
	current_scene = ScenesManager.get_current_scene()
	update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "CityCentre":
		scene.get_node("NPC/Gaia").set_process_mode(PROCESS_MODE_DISABLED)
		scene.get_node("NPC/Gaia").visible = false
		
		if !ThirdMission.is_mission_completed:
			scene.get_node("InteractiveItem/Office").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			if first_time_entering:
				office_presentation(scene)

func office_presentation(scene : Node2D):
	first_time_entering = false
	scene.get_node("NPC/Gaia").set_process_mode(PROCESS_MODE_INHERIT)
	scene.get_node("NPC/Gaia").visible = true
	Dialogic.start("gaiaOfficeTimeline0")
			
func reset_scene() -> void:
	is_mission_completed = false
	first_time_entering = true
