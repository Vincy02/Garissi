extends TextureButton

var node

signal check_puzzle_completed

func _ready():
	if get_parent().name == "Control":
		node = get_node("../../../..")
	else:
		node = get_node("../../../../..")
	connect("check_puzzle_completed", Callable(node, "check_puzzle"))
	pivot_offset = Vector2(custom_minimum_size.x/2,custom_minimum_size.y/2)
	var rng = RandomNumberGenerator.new()
	rotation_degrees = rng.randi_range(0,3)*90

func _get_drag_data(at_position):
	if texture_normal != null:
		set_drag_preview(get_preview())
		return self
	else:
		return null
	
func _can_drop_data(at_position, data):
	return data is TextureButton
	
func _drop_data(at_position, data):
	var temp = {
	"degrees": rotation_degrees,
	"texture": texture_normal,
	};
	
	texture_normal = data.texture_normal
	rotation_degrees = data.rotation_degrees
	
	if temp["texture"] != null:
		data.texture_normal = temp["texture"]
		data.rotation_degrees = temp["degrees"]
	else:
		data.texture_normal = null
		data.rotation_degrees = 0
		
	emit_signal("check_puzzle_completed")
	
func get_preview():
	# Dragging preview
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = texture_normal
	preview_texture.rotation_degrees = rotation_degrees
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(50,50)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	return preview

func _on_pressed():
	rotation_degrees = int(rotation_degrees+90)%360
	emit_signal("check_puzzle_completed")
	
