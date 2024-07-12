extends Node

var is_mission_completed = false
var current_scene
var priest_first_dialogue = false
var candle_picked = false

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "give_newspaper":
		priest_first_dialogue = true
		check_progession()
	if arg == "candle":
		candle_picked = true
		check_progession()
	if arg == "start_minigame_candlestick":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/Missions/minigameCandlestick.tscn")
		
func minigame_completed():
	is_mission_completed = true
	Dialogic.start("priestTimeline2")

func check_progession() -> void:
	current_scene = ScenesManager.get_current_scene()
	update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "PostOffice":
		if !FifthMission.is_mission_completed && !priest_first_dialogue:
			scene.get_node("InteractiveItem/Candle").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			scene.get_node("InteractiveItem/Candle").set_process_mode(PROCESS_MODE_INHERIT)
		if candle_picked:
			scene.get_node("InteractiveItem/Candle").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("InteractiveItem/Candle").visible = false
	if scene.name == "CityCentre":
		if !FifthMission.is_mission_completed:
			pass
			#scene.get_node("../Block").set_mode(SET_MODE_DISABLED)
			#scene.get_node("../Block").visible = false
		#else:
		#	...
	if scene.name == "Church":
		if priest_first_dialogue:
			scene.get_node("NPC/Priest").timeline = "priestTimeline1"
		if candle_picked:
			scene.get_node("NPC/Priest").timeline = "priestTimeline2"
			scene.get_node("Candelabro").set_process_mode(PROCESS_MODE_INHERIT)
		else:
			scene.get_node("InteractiveItem/Candelabro").set_process_mode(PROCESS_MODE_DISABLED)
		if !is_mission_completed:
			pass
			#DISABILITARE TUTTI I PERSONAGGI NELLA CHIESA:
		else:
			scene.get_node("NPC/Priest").timeline = "priestTimeline4"
	if scene.name == "Square":
		if FifthMission.is_mission_completed:
			scene.get_node("AdPanel2").visible = false
			scene.get_node("FuneralSign").visible = true
		else:
			scene.get_node("AdPanel2").visible = true
			scene.get_node("FuneralSign").visible = false
			
func reset_scene() -> void:
	is_mission_completed = false
	priest_first_dialogue = false
	candle_picked = false
