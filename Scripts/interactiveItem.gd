extends Area2D

var entered = false

@onready var interaction = $"../Interaction"
@export var is_pickable = false
@export var is_interactable = false
@export var arg = ""

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
	interaction.set_action("per interagire")
	interaction.visible = false
	
func _process(delta):
	if entered && Input.is_action_just_pressed("Interact"):
		interaction.visible = false
		if !is_pickable && !is_interactable:
			var path = "res://Scenes/" + arg + ".tscn"
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file(path)
		if is_interactable:
			Dialogic.start(arg)

func _on_body_entered(_body):
	if _body is Player:
		entered = true
		interaction.visible = true

func _on_body_exited(_body):
	if _body is Player:
		entered = false
		interaction.visible = false

func dialogicSignal(arg: String) -> void:
	if is_interactable:
		if arg == "ended_conversation":
			interaction.visible = true
		if arg == "started_conversation":
			interaction.visible = false
