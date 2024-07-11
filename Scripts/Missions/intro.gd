extends CanvasLayer

@onready var label_text = $MarginContainer/VBoxContainer/Label
@onready var park = "res://Scenes/park.tscn"
var dialogue_index = 0
var transition = false
var text_to_show = ""
var stop_input = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(dialogicSignal)
	main_loop()

func _input(event):
	if !stop_input:
		if Input.is_action_just_pressed("dialogic_default_action") && transition:
			transition = false
		else:
			if Input.is_action_just_pressed("dialogic_default_action") && !transition:
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
			stop_input = true
		4:
			text_to_show = "Suono di chiamata terminata."
			start_text_transition()
		5:
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file(park)
			Dialogic.start("marioTimeline0")
			MainThemeTrack.play()
			

func dialogicSignal(arg: String) -> void:
	if arg == "ended_conversation":
		stop_input = false
