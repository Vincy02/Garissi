extends CharacterBody2D

@export var speed: int = 500
var animated_sprite: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 500)
	animated_sprite = $AnimatedSprite2D
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
