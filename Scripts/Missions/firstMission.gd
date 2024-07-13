extends Node

const PARK_NPC = 5

var is_mission_completed = false
var npc_interacted_first_mission = {}
var current_scene
var unlock_door = false

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)

func npc_interacted(npc):
	if npc.name != "TechnicianMario":
		npc_interacted_first_mission[npc] = npc
		check_progession()
		
func dialogicSignal(arg: String) -> void:
	if arg == "unlock_park_door":
		if !unlock_door:
			unlock_door = true
			ScenesManager.transition_mission_completed()
			current_scene = ScenesManager.get_current_scene()
			update_world_status(current_scene)
			
		
func check_progession() -> void:
	if npc_interacted_first_mission.size() >= PARK_NPC:
		current_scene = ScenesManager.get_current_scene()
		is_mission_completed = true
		update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "Park":
		if is_mission_completed:
			scene.get_node("NPC/TechnicianMario").timeline = "marioTimeline2"
			if unlock_door:
				scene.get_node("BuildingCollision/CollisionShapeExit").disabled = true
				scene.get_node("TrunksSquare").visible = false
				scene.get_node("Doors/Door_E").set_process_mode(PROCESS_MODE_INHERIT)
		else:
			scene.get_node("Doors/Door_E").set_process_mode(PROCESS_MODE_DISABLED)
			
func reset_scene() -> void:
	unlock_door = false
	is_mission_completed = false
	npc_interacted_first_mission = {}
