extends Control

var solution = [45, 135, 0, 0, 90, 0]
var path = "res://Scenes/newsStand.tscn"

signal minigame_battery_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("minigame_battery_completed", Callable(SecondMission, "minigame_completed"))
	for i in range(1,7):
		var button_name = "Button" + str(i)
		var button_node = get_node(button_name)
		button_node.connect("pressed", Callable(self, "button_pressed").bind(button_node))
		button_node.pivot_offset = Vector2(button_node.size.x/2, button_node.size.y/2)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func button_pressed(button : TextureButton):
	button.rotation_degrees = int((button.rotation_degrees+45))%180
	if check_solution():
		emit_signal("minigame_battery_completed")
		back_to_news_stand()
		
func back_to_news_stand():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(path)
	Player.set_player_position(Vector2(772, 359), "right")
	
func check_solution():
	for i in range(1,7):
		var button_name = "Button" + str(i)
		var button_node = get_node(button_name)
		if button_node.rotation_degrees == solution[i-1]:
			continue
		else:
			return false
	return true
	
func _input(event):
	if Input.is_action_just_pressed("Pause"):
		back_to_news_stand()
