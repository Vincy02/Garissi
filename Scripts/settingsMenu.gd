extends Control

@onready var brightnessPerc = $PanelContainer/MarginContainer/Control/PercentageContainer/BrightnessPercentage as Label
@onready var volumePerc = $PanelContainer/MarginContainer/Control/PercentageContainer/VolumePercentage as Label
@onready var brightness = $PanelContainer/MarginContainer/Control/VBoxContainer/Brightness/BrightnessSlider as HSlider
@onready var volume = $PanelContainer/MarginContainer/Control/VBoxContainer/Volume/VolumeSlider as HSlider
@onready var fullscreenCheckBox = $PanelContainer/MarginContainer/Control/VBoxContainer/FullScreen/CheckBox as CheckBox

var brightness_percentage = {
	"0.5": "0",
	"0.6": "10",
	"0.7": "20",
	"0.8": "30",
	"0.9": "40",
	"1": "50",
	"1.1": "60",
	"1.2": "70",
	"1.3": "80",
	"1.4": "90",
	"1.5": "100"
}

# Called when the node enters the scene tree for the first time.
func _ready():	
	# connect func for elements
	fullscreenCheckBox.button_up.connect(_toggle_fullscreen)
	brightness.value_changed.connect(_change_brightness)
	# load fullscreen var
	var video_settings = SettingsManager.load_video_settings()
	fullscreenCheckBox.button_pressed = video_settings.fullscreen
	var fullscreen = fullscreenCheckBox.button_pressed
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	# load brightness var
	brightness.value = min(video_settings.brightness, 1.5)
	WordlEnvironment.environment.adjustment_brightness = brightness.value
	brightnessPerc.text = brightness_percentage[str(brightness.value)] + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	volumePerc.text = str(volume.value) + "%"
	pass
		
func _change_brightness(value) -> void:
	brightnessPerc.text = brightness_percentage[str(brightness.value)] + "%"
	WordlEnvironment.environment.adjustment_brightness = value
	SettingsManager.save_video_setting("brightness", value)

func _toggle_fullscreen() -> void:
	var fullscreen = fullscreenCheckBox.button_pressed
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	SettingsManager.save_video_setting("fullscreen", fullscreen)
