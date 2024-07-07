extends Node

var is_mission_completed = false
var transition_barCustomer5 = false
var current_scene

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "second_mission_completed":
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)		
	if arg == "third_mission_completed":
		is_mission_completed = true
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)

func check_progession() -> void:
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "Square":
		if !SecondMission.is_mission_completed:
			scene.get_node("Doors/Door_Bar").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			scene.get_node("Doors/Door_Bar").set_process_mode(PROCESS_MODE_INHERIT)
	if scene.name == "Bar":
		if !is_mission_completed:
			scene.get_node("Doors/Door_S").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			scene.get_node("Doors/Door_S").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/BarCustomer5").set_process_mode(PROCESS_MODE_DISABLED)
			if !transition_barCustomer5:
				transition_barCustomer5 = true
				TransitionScreen.transition()
				await TransitionScreen.on_transition_finished
			scene.get_node("NPC/BarCustomer5").visible = false
			
func reset_scene() -> void:
	is_mission_completed = false
	transition_barCustomer5 = false
