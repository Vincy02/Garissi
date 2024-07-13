extends Node

var bus = "master"
var sound

@onready var audioPool = []  # Array to store AudioStreamPlayer nodes

func _ready():
	# Assuming you have a specific number of players needed
	for i in range(5):  # Create 5 AudioStreamPlayer nodes
		var player = AudioStreamPlayer.new()
		player.bus = "master"
		audioPool.append(player)
		add_child(player)  # Add players to the scene tree (optional)

func play(arg: String):
	for player in audioPool:
		if not player.playing:  # Check if a player is available
			player.stream = load(arg)
			player.play()
			return  # Exit the function after playing on the first available player
	print("No available players in the pool!")  # Handle the case where no player is available
	
func stop(audio_stream_path: String):
	for player in audioPool:
		if player.playing and player.stream.resource_path == audio_stream_path:
			player.stop()
			break  # Stop iterating after finding and stopping the player

