extends CanvasLayer

@onready var label_text = $MarginContainer/VBoxContainer/Label
var dialogue_index = 0
var transition = false
var text_to_show = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	next_dialogue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && transition:
		transition = false
		label_text.text = text_to_show
	else:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && !transition:
			next_dialogue()

func start_transiotion() -> void:
	label_text.text = ""
	transition = true
	for i in text_to_show:
		if !transition:
			break
		else:
			await wait_seconds(0.1)
			label_text.text += i
	transition = false

func wait_seconds(seconds: float):
	await get_tree().create_timer(seconds).timeout

func next_dialogue() -> void:
	dialogue_index += 1
	match dialogue_index:
		1:
			text_to_show = "Ciao Luca ajksdhajkshdjkahdkjashdjkahjkdhjkaasdasdsdakjshdjkashdjkashjkd"
		2:
			text_to_show = "Ciao Rocco"
		3:
			text_to_show = ""
	start_transiotion()
