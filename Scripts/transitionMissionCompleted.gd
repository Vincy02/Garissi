extends CanvasLayer

signal on_transition_finished

@onready var scene = $"."
@onready var animation_player = $AnimationPlayer

func _ready():
	scene.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func transition():
	scene.visible = true
	animation_player.play("mission_completed_animation")
	
func _on_animation_finished(anim_name):
	if anim_name == "mission_completed_animation":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		scene.visible = false
	
