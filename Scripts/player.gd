class_name Player
extends CharacterBody2D

@export var speed: int = 500

var animated_sprite: AnimatedSprite2D
static var player: Player = null
static var SCALE_PLAYER = 0.2
static var set_player_position_bool = false

func _init():
	if not player:
		player = self

# Called when the node enters the scene tree for the first time.
func _ready():
		animated_sprite = $AnimatedSprite2D
		NavigationManager.on_trigger_player_spawn.connect(_on_spawn)

static func get_player():
	return player

func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animated_sprite.play("idle")
	if(direction == "left"):
		animated_sprite.flip_h = 1

static func set_player_position(position: Vector2, direction: String):
	if player:
		player.global_position = position
		if(direction == "right"):
			player.scale.x = -SCALE_PLAYER
			set_player_position_bool = true
	else:
		print("Rocco e' gay")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * speed
	move_and_slide()
	if velocity.length_squared() == 0:
		animated_sprite.play("idle")
	else:
		if set_player_position_bool:
			scale.x = -SCALE_PLAYER
			set_player_position_bool = false
		animated_sprite.play("walk")
	
	if(direction.x > 0): animated_sprite.flip_h = 1
	if(direction.x < 0): animated_sprite.flip_h = 0
