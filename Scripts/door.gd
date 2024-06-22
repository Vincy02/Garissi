class_name Door
extends Area2D

@onready var spawn = $Spawn

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = ""

var entered = false
var body = ""

func _process(delta):
	if body is Player && entered && Input.is_action_just_pressed("Interact"):
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		
func _on_body_entered(_body):
	entered = true
	body = _body

func _on_body_exited(body):
	entered = false
