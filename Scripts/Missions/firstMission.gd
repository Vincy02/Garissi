extends Node

const PARK_NPC = 5

@onready var is_mission_completed = false
var npc_interacted_first_mission = {}
var current_scene

func npc_interacted(npc):
	if npc.name != "TechnicianMario":
		npc_interacted_first_mission[npc] = npc
		check_progession()
		
func check_progession() -> void:
	# Implement mission
	if npc_interacted_first_mission.size() >= PARK_NPC:
		current_scene = ScenesManager.get_current_scene()
		is_mission_completed = true
		update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "Park":
		if is_mission_completed:
			scene.get_node("NPC/TechnicianMario").timeline = "marioTimeline2"
			scene.get_node("Doors/Door_E").set_process_mode(PROCESS_MODE_INHERIT)
		else:
			scene.get_node("Doors/Door_E").set_process_mode(PROCESS_MODE_DISABLED)
