extends Node

var is_mission_completed = false
var newspaper_given = false
var door_headOffice = false
var headOffice = "res://Scenes/headOffice.tscn"
var current_scene

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "give_newspaper":
		newspaper_given = true
		InventoryManager.add_item("newsClockTower")
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		check_progession()
	if arg == "door_headOffice_unlocked":
		door_headOffice = true
		check_progession()
	if arg == "door_headOffice_still_locked":
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		Player.set_player_position(Vector2(729, 362), "right")
		check_progession()

func check_progession() -> void:
	current_scene = ScenesManager.get_current_scene()
	update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "PostOffice":
		if newspaper_given:
			scene.get_node("NPC/Elder1").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("NPC/Elder1").visible = false
		if door_headOffice:
			scene.get_node("Doors/Door_HeadOffice").set_process_mode(PROCESS_MODE_INHERIT)
			scene.get_node("Doors/Door_HeadOffice").visible = true
			scene.get_node("InteractiveItem/HeadOfficeDoor").set_process_mode(PROCESS_MODE_DISABLED)
		else:
			scene.get_node("Doors/Door_HeadOffice").set_process_mode(PROCESS_MODE_DISABLED)
			scene.get_node("Doors/Door_HeadOffice").visible = false
			
func reset_scene() -> void:
	is_mission_completed = false
	newspaper_given = false
	door_headOffice = false
