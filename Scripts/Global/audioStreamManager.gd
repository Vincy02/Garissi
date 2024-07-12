extends Node

@onready var player = $AudioStreamPlayer
var bus = "master"
const sound = preload("res://Audio/itemDropped.mp3")

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	player.bus = bus
	player.stream = sound
	
func play():
	player.play()
