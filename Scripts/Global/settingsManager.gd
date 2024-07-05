extends Node

const SETTINGS_FILE_PATH = "user://settings.ini"
const DEFAULT_AUDIO_VOLUME = 20
const DEFULT_FULLSCREEN = 0
const DEFULT_BRIGHTNESS = 1
const DEFULT_RESOLUTION = 1
const input_actions = [
	"MoveUp",
	"MoveDown",
	"MoveLeft",
	"MoveRight",
	"Interact",
	"Inventory"
]

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		## KEYBINDS ##
		InputMap.load_from_project_settings()
		for action in input_actions:
			var events = InputMap.action_get_events(action)
			if events.size() > 0:
				config.set_value("keybinds", action, events[0].as_text().trim_suffix(" (Physical)"))
		## AUDIO ##
		config.set_value("audio", "master", DEFAULT_AUDIO_VOLUME)
		## VIDEO ##
		config.set_value("video", "fullscreen", DEFULT_FULLSCREEN)
		config.set_value("video", "brightness", DEFULT_BRIGHTNESS)
		config.set_value("video", "resolution", DEFULT_RESOLUTION)
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
	
func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings
	
func save_keybinds_settings(action: StringName, event: InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouseButton:
		event_str = "mouse_" + str(event.button_index)
		
	config.set_value("keybinds", action, event_str)
	config.save(SETTINGS_FILE_PATH)
	
func load_keybinds_settings():
	var keybinds_settings = {}
	var keys = config.get_section_keys("keybinds")
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinds", key)
		
		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
		
		keybinds_settings[key] = input_event
	
	return keybinds_settings
