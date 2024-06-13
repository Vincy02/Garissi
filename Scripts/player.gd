extends CharacterBody2D

class_name Player
@export var speed: int = 500
@export var map: Sprite2D
var animated_sprite: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var x = (map.texture.get_size().x * map.scale.x)/2
	var y = (map.texture.get_size().y * map.scale.y)/2
	position = Vector2(x, y)
	animated_sprite = $AnimatedSprite2D
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animated_sprite.play("idle")
	if(direction == "left"):
		animated_sprite.flip_h = 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * speed
	move_and_slide()
	if velocity.length_squared() == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walk")
	
	if(direction.x > 0): animated_sprite.flip_h = 1
	if(direction.x < 0): animated_sprite.flip_h = 0
