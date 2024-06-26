extends Control

@onready var brightness_percentage = $PanelContainer/MarginContainer/Control/PercentageContainer/BrightnessPercentage as Label
@onready var volume_percentage = $PanelContainer/MarginContainer/Control/PercentageContainer/VolumePercentage as Label
@onready var brightness_slider = $PanelContainer/MarginContainer/Control/VBoxContainer/Brightness/BrightnessSlider as HSlider
@onready var volume_slider = $PanelContainer/MarginContainer/Control/VBoxContainer/Volume/VolumeSlider as HSlider
@onready var fullscreen_checkBox = $PanelContainer/MarginContainer/Control/VBoxContainer/FullScreen/CheckBox as CheckBox
@onready var resolution_button = $PanelContainer/MarginContainer/Control/VBoxContainer/Res/ResButton as OptionButton

var resolution_dictionary : Dictionary = {
	"720 x 480" : Vector2i(720, 480),
	"1280 x 720" : Vector2i(1280, 720),
	"1920 x 1080" : Vector2i(1920, 1080)
}
var brightness_dictionary : Dictionary = {
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
	fullscreen_checkBox.button_up.connect(_toggle_fullscreen)
	brightness_slider.value_changed.connect(_change_brightness)
	resolution_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	# load fullscreen var
	var video_settings = SettingsManager.load_video_settings()
	fullscreen_checkBox.button_pressed = video_settings.fullscreen
	var fullscreen = fullscreen_checkBox.button_pressed
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	# load resoultion var
	on_resolution_selected(video_settings.resolution)
	resolution_button.selected = video_settings.resolution
	# load brightness var
	brightness_slider.value = min(video_settings.brightness, 1.5)
	WordlEnvironment.environment.adjustment_brightness = brightness_slider.value
	brightness_percentage.text = brightness_dictionary[str(brightness_slider.value)] + "%"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	volume_percentage.text = str(volume_slider.value) + "%"
		
func add_resolution_items() -> void:
	for resolution_size_text in resolution_dictionary:
		resolution_button.add_item(resolution_size_text)
		
func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(resolution_dictionary.values()[index])
	# Need to figure out how to center the window only on resolution changes
	# var screen = DisplayServer.screen_get_size(0)
	# get_window().position = (screen/2) - get_window().size/2
	SettingsManager.save_video_setting("resolution", index)
		
func _change_brightness(value) -> void:
	brightness_percentage.text = brightness_dictionary[str(brightness_slider.value)] + "%"
	WordlEnvironment.environment.adjustment_brightness = value
	SettingsManager.save_video_setting("brightness", value)

func _toggle_fullscreen() -> void:
	var fullscreen = fullscreen_checkBox.button_pressed
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	SettingsManager.save_video_setting("fullscreen", fullscreen)
