extends Camera2D

@export var map: Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	limit_right = map.texture.get_size().x * map.scale.x
	limit_bottom = map.texture.get_size().y * map.scale.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
