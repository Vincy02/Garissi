extends Node

var is_mission_completed = false
var sophie_quest_accepted = false
var battery_given = false
var photo_given = false
var current_scene

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
		
func dialogicSignal(arg: String) -> void:
	if arg == "change_sophie_timeline":
		sophie_quest_accepted = true
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)
	if arg == "give_battery":
		battery_given = true
		InventoryManager.add_item("battery")
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)
	if arg == "give_photoSophie" && battery_given:
		photo_given = true
		is_mission_completed = true
		InventoryManager.add_item("photoSophie")
		InventoryManager.remove_item("battery")
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)

func check_progession() -> void:
		current_scene = ScenesManager.get_current_scene()
		update_world_status(current_scene)

func update_world_status(scene : Node2D) -> void:
	if scene.name == "Square":
		if sophie_quest_accepted && !battery_given:
			scene.get_node("NPC/Sophie").timeline = "sophieTimeline1"
		if sophie_quest_accepted && battery_given:
			scene.get_node("NPC/Sophie").timeline = "sophieTimeline2"
		if photo_given:
			scene.get_node("NPC/Sophie").timeline = "sophieTimeline3"
	if scene.name == "NewsStand":
		if sophie_quest_accepted && !battery_given:
			scene.get_node("NPC/Simone").timeline = "simoneTimeline1"
		if sophie_quest_accepted && battery_given:
			scene.get_node("NPC/Simone").timeline = "simoneTimeline0"
			
func reset_scene() -> void:
	is_mission_completed = false
	sophie_quest_accepted = false
	battery_given = false
	photo_given = false
