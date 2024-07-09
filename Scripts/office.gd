extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func back_to_city_centre():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/cityCentre.tscn")
	Player.set_player_position(Vector2(240, 1154), "left")
	
func _input(event):
	if Input.is_action_just_pressed("Pause"):
		back_to_city_centre()
