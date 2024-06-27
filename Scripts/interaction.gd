extends CanvasLayer

@onready var label = $ColorRect/VBoxContainer/Label
var action = ""

func set_action(text: String) -> void:
	action = text

func _process(delta):
	var interaction_key = InputMap.action_get_events("Interact")[0].as_text().trim_suffix(" (Physical)")
	label.text = "Premi [ " + interaction_key + " ] " + action
