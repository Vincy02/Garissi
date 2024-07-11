class_name InteractiveItem
extends Area2D

var entered = false
var aux = false

@onready var interaction = $"../Interaction"
@export var is_pickable = false
@export var is_interactable = false
@export var arg = ""
static var is_interacting = false

func _ready():
	interaction.set_action("per interagire")
	interaction.visible = false
	
func _process(delta):
	if entered && !is_interacting:
		if Input.is_action_just_pressed("Interact") && !aux:
			aux = true
			if !is_pickable && !is_interactable:
				var path = "res://Scenes/" + arg + ".tscn"
				TransitionScreen.transition()
				await TransitionScreen.on_transition_finished
				get_tree().change_scene_to_file(path)
			if is_interactable:
				Dialogic.start(arg)
		else:
			interaction.visible = true
	if is_interacting:
		interaction.visible = false

func _on_body_entered(_body):
	if _body is Player:
		entered = true
		interaction.visible = true

func _on_body_exited(_body):
	if _body is Player:
		entered = false
		interaction.visible = false

static func set_is_interacting(arg: bool):
	is_interacting = arg
