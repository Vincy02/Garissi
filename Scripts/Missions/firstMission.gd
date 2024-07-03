extends Node

@onready var technicianMario

var npcInteracted = {}

func npc_interacted(npc):
	if npc.name != "TechnicianMario":
		npcInteracted[npc] = npc
		check_progession()
	else:
		technicianMario = npc
		npcInteracted[npc] = npc
		check_progession()
		
func check_progession() -> void:
	# Implement mission
	return
		
func start() -> void:
	# Display start animation
	# Setup scene and npc
	return
