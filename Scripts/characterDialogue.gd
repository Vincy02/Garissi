extends Area2D

var entered = false
var turned = false

@onready var interaction = $Interaction
@onready var character = $Body
@export var timeline = ""

func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
	interaction.set_action("per interagire")
	interaction.visible = false
	
func _process(delta):
	if entered && Input.is_action_just_pressed("Interact"):
		flipPlayer()
		interaction.visible = false
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
		reset_position()

func flipPlayer() -> void:
	if (character.global_position[0] < Player.get_player_position_x() && character.flip_h == 0) || (character.global_position[0] > Player.get_player_position_x() && character.flip_h == 1):
		character.flip_h = !character.flip_h
		turned = true
		
func reset_position() -> void:
	if turned:
		character.flip_h = !character.flip_h
		turned = false
