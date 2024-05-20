extends CharacterBody2D

@export var speed: int = 500
var animated_sprite: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 500)
	animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * speed
	move_and_slide()
	
	if direction.x < 0:
		animated_sprite.play("walk_left")
	elif direction.x > 0:
		animated_sprite.play("walk_right")
	else:
		if direction.y < 0:
			animated_sprite.play("walk_left")
		elif direction.y > 0:
			animated_sprite.play("walk_right")
		else:
			if velocity.length_squared() == 0:
				if animated_sprite.animation != "idle_right":
					animated_sprite.play("idle_left")
				elif animated_sprite.animation != "idle_left":
					animated_sprite.play("idle_right")
