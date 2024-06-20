extends Control

@onready var brightnessPerc = $PanelContainer/MarginContainer/Control/PercentageContainer/BrightnessPercentage as Label
@onready var volumePerc = $PanelContainer/MarginContainer/Control/PercentageContainer/VolumePercentage as Label
@onready var brightness = $PanelContainer/MarginContainer/Control/VBoxContainer/Brightness/BrightnessSlider as HSlider
@onready var volume = $PanelContainer/MarginContainer/Control/VBoxContainer/Volume/VolumeSlider as HSlider
@onready var checkBox = $PanelContainer/MarginContainer/Control/VBoxContainer/FullScreen/CheckBox as CheckBox
var fullscreen = false

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
	brightnessPerc.text = brightness_percentage[str(brightness.value)] + "%"
	checkBox.button_up.connect(_on_button_clicked)
	brightness.value_changed.connect(_on_value_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	volumePerc.text = str(volume.value) + "%"
	pass
		
func _on_value_changed(value) -> void:
	brightnessPerc.text = brightness_percentage[str(brightness.value)] + "%"
	WordlEnvironment.environment.adjustment_brightness = value

func _on_button_clicked() -> void:
	fullscreen = !fullscreen
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
