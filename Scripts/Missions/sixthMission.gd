extends Node

var is_mission_completed = false
var current_scene
var priest_quest_accepted = true
var candle_picked = true
var candlestick_minigame_unlocked = false

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "priest_quest_accepted":
		priest_quest_accepted = true
		check_progession()
	if arg == "give_candle":
		candle_picked = true
		check_progession()
	if arg == "unlock_candlestick_minigame":
		candlestick_minigame_unlocked = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		check_progession()
	if arg == "start_minigame_candlestick":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/Missions/minigameCandlestick.tscn")
	if arg == "sixth_mission_completed":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		is_mission_completed = true
		check_progession()
		
func minigame_completed():
	Dialogic.start("priestTimeline2")
	

func check_progession() -> void:
	current_scene = ScenesManager.get_current_scene()
	update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "PostOffice":
		if !(FifthMission.is_mission_completed && priest_quest_accepted):
			scene.get_node("InteractiveItem/Candle").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			scene.get_node("InteractiveItem/Candle").set_process_mode(PROCESS_MODE_INHERIT)
		if candle_picked:
			scene.get_node("InteractiveItem/Candle").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("InteractiveItem/Candle").visible = false
	if scene.name == "CityCentre":
		if !FifthMission.is_mission_completed:
			scene.get_node("Doors/Door_Church").set_process_mode(PROCESS_MODE_DISABLED)
	if scene.name == "Church":
		if priest_quest_accepted && candle_picked:
			scene.get_node("NPC/Priest").timeline = "priestTimeline1"
		if candle_picked && candlestick_minigame_unlocked:
			scene.get_node("InteractiveItem/Candlestick2/Body").texture = ResourceLoader.load("res://Sprites/CityCentre/Church/candlestick.png")
			scene.get_node("InteractiveItem/Candlestick1").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("InteractiveItem/Candlestick2").set_process_mode(PROCESS_MODE_INHERIT)
		else:
			scene.get_node("InteractiveItem/Candlestick1").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("InteractiveItem/Candlestick2").set_process_mode(PROCESS_MODE_DISABLED)
		if !is_mission_completed:
			scene.get_node("NPC/TinosBrother").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/TinosBrother").visible = false
			scene.get_node("NPC/TinosFriend1").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/TinosFriend1").visible = false
			scene.get_node("NPC/TinosFriend2").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/TinosFriend2").visible = false
			scene.get_node("NPC/TinosFriend3").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/TinosFriend3").visible = false
			scene.get_node("NPC/Shifu").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/Shifu").visible = false
			scene.get_node("NPC/Employee1").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/Employee1").visible = false
			scene.get_node("NPC/Employee2").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/Employee2").visible = false
			scene.get_node("NPC/Elder").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/Elder").visible = false
		else:
			scene.get_node("NPC/Priest").timeline = "priestTimeline3"
			scene.get_node("InteractiveItem/Candlestick1").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("InteractiveItem/Candlestick2").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/TinosBrother").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/TinosBrother").visible = true
			scene.get_node("NPC/TinosFriend1").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/TinosFriend1").visible = true
			scene.get_node("NPC/TinosFriend2").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/TinosFriend2").visible = true
			scene.get_node("NPC/TinosFriend3").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/TinosFriend3").visible = true
			scene.get_node("NPC/Shifu").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/Shifu").visible = true
			scene.get_node("NPC/Employee1").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/Employee1").visible = true
			scene.get_node("NPC/Employee2").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/Employee2").visible = true
			scene.get_node("NPC/Elder").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("NPC/Elder").visible = true
			
	if scene.name == "Square":
		if FifthMission.is_mission_completed:
			scene.get_node("AdPanel2").visible = false
			scene.get_node("FuneralSign").visible = true
		else:
			scene.get_node("AdPanel2").visible = true
			scene.get_node("FuneralSign").visible = false
			
func reset_scene() -> void:
	is_mission_completed = false
	priest_quest_accepted = false
	candle_picked = false
	candlestick_minigame_unlocked = false
