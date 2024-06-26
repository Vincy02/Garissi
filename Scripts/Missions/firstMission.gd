extends CanvasLayer

@onready var label_text = $MarginContainer/VBoxContainer/Label
@onready var park = "res://Scenes/park.tscn"
var dialogue_index = 0
var transition = false
var text_to_show = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	main_loop()

func _unhandled_input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && transition:
		transition = false
	else:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && !transition:
			main_loop()

func start_text_transition() -> void:
	label_text.text = ""
	transition = true
	for i in text_to_show:
		if !transition:
			label_text.text = text_to_show
			break
		else:
			await wait_seconds(0.1)
			label_text.text += i
	transition = false

func wait_seconds(seconds: float):
	await get_tree().create_timer(seconds).timeout

func main_loop() -> void:
	dialogue_index += 1
	match dialogue_index:
		1:
			text_to_show = "Garissi 2015"
			start_text_transition()
		2:
			text_to_show = "Suono di telefono che squilla.\nFabrizio risponde."
			start_text_transition()
		3:
			text_to_show = ""
			start_text_transition()
			Dialogic.start("intro")
		4:
			text_to_show = "Suono di chiamata terminata."
			start_text_transition()
		5:
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file(park)
			Player.set_player_position(Vector2(1316, 740), "right")
	
