class_name Door
extends Area2D

@onready var spawn = $Spawn
@onready var interaction = $Interaction
@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = ""

var entered = false
var body = ""

func _ready():
	interaction.set_action("per interagire")
	interaction.visible = false
	
func _process(delta):
	if body is Player && entered && Input.is_action_just_pressed("Interact"):
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		
func _on_body_entered(_body):
	if _body is Player:
		entered = true
		interaction.visible = true
		body = _body

func _on_body_exited(body):
	if body is Player:
		entered = false
		interaction.visible = false
