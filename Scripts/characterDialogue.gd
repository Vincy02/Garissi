extends Area2D

var entered = false
var turned = false
var is_interacting = false

@onready var interaction = $"../Interaction"
@onready var character = $Body
@export var timeline = ""

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
	interaction.set_action("per interagire")
	interaction.visible = false
	
func _process(delta):
	if entered && Input.is_action_just_pressed("Interact") && !is_interacting:
		flipPlayer()
		interaction.visible = false
		FirstMission.npc_interacted(character.get_parent())
		Dialogic.start(timeline)

func _on_body_entered(_body):
	if _body is Player:
		entered = true
		interaction.visible = true

func _on_body_exited(_body):
	if _body is Player:
		entered = false
		interaction.visible = false

func dialogicSignal(arg: String) -> void:
	if arg == "ended_conversation":
		interaction.visible = true
		is_interacting = false
		reset_position()
	if arg == "started_conversation":
		interaction.visible = false
		is_interacting = true

func flipPlayer() -> void:
	if (character.global_position[0] < Player.get_player_position_x() && character.flip_h == false) || (character.global_position[0] > Player.get_player_position_x() && character.flip_h == true):
		character.flip_h = !character.flip_h
		turned = true
		
func reset_position() -> void:
	if turned:
		character.flip_h = !character.flip_h
		turned = false
