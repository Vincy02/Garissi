extends Area2D

var entered = false

@onready var interaction = $"../Interaction"
@export var is_pickable = false
@export var scene = ""

func _ready():
	interaction.set_action("per interagire")
	interaction.visible = false
	
func _process(delta):
	if entered && Input.is_action_just_pressed("Interact"):
		interaction.visible = false
		if !is_pickable:
			var path = "res://Scenes/" + scene + ".tscn"
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file(path)

func _on_body_entered(_body):
	if _body is Player:
		entered = true
		interaction.visible = true

func _on_body_exited(_body):
	if _body is Player:
		entered = false
		interaction.visible = false
