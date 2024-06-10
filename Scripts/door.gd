extends Area2D

class_name Door


@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = ""

@onready var spawn = $Spawn
var entered = false
var body = ""

func _process(delta):
	if body is Player and entered and Input.is_action_just_pressed("Interact"):
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		
func _on_body_entered(_body):
	entered = true
	body = _body


func _on_body_exited(body):
	entered = false
