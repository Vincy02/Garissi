extends Node

var is_mission_completed = false
var transition_barCustomer5 = false
var transition_mayor = false
var current_scene

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "second_mission_completed":
		check_progession()	
	if arg == "third_mission_completed":
		if !is_mission_completed:
			ScenesManager.transition_mission_completed()
			is_mission_completed = true
			check_progession()
	if arg == "mayor_interaction":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		transition_mayor = true
		check_progession()

func check_progession() -> void:
	current_scene = ScenesManager.get_current_scene()
	update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "Square":
		if !SecondMission.is_mission_completed:
			scene.get_node("Doors/Door_Bar").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			scene.get_node("TrunksBar").visible = false
			scene.get_node("Doors/Door_Bar").set_process_mode(PROCESS_MODE_INHERIT)
	if scene.name == "Bar":
		if transition_mayor:
			scene.get_node("NPC/Mayor").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/Mayor").visible = false
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
	transition_mayor = false
