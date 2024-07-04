extends Node

@onready var mission_completed = false
var current_scene
var door

var npcInteracted = {}

func set_current_scene(scene) -> void:
	current_scene = scene 
	if scene.name == "Park":
		if mission_completed:
			scene.get_node("NPC/TechnicianMario").timeline = "marioTimeline2"
		else:
			door = current_scene.get_node("Doors/Door_E")
			scene.get_node("Doors/Door_E").set_process_mode(PROCESS_MODE_DISABLED)
	

func npc_interacted(npc):
	if npc.name != "TechnicianMario":
		npcInteracted[npc] = npc
		check_progession()
		
func check_progession() -> void:
	# Implement mission
	if npcInteracted.size() == 1:
		mission_completed = true
		current_scene.get_node("NPC/TechnicianMario").timeline = "marioTimeline2"
		current_scene.get_node("Doors/Door_E").set_process_mode(PROCESS_MODE_INHERIT)
		
func start() -> void:
	# Display start animation
	# Setup scene and npc
	return
