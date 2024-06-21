extends Node

var input_actions = [
	"MoveUp",
	"MoveDown",
	"MoveLeft",
	"MoveRight",
	"Interact"
]

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"
const DEFAULT_AUDIO_VOLUME = 20
const DEFULT_FULLSCREEN = 0
const DEFULT_BRIGHTNESS = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		## KEYBINDING ##
		InputMap.load_from_project_settings()
		for action in input_actions:
			var events = InputMap.action_get_events(action)
			if events.size() > 0:
				config.set_value("keybinding", action, events[0].as_text().trim_suffix(" (Physical)"))
		## AUDIO ##
		config.set_value("audio", "master", DEFAULT_AUDIO_VOLUME)
		## VIDEO ##
		config.set_value("video", "fullscreen", DEFULT_FULLSCREEN)
		config.set_value("video", "brightness", DEFULT_BRIGHTNESS)
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
	

