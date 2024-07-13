class_name Player
extends CharacterBody2D

@export var speed: int = 500
@export var facing: String = "left"

var animated_sprite: AnimatedSprite2D
static var move = true
static var player: Player = null
@onready var foot_step = $FootStep

func _init():
	if not player:
		player = self

# Called when the node enters the scene tree for the first time.
func _ready():
	if not player:
		player = self
	animated_sprite = $AnimatedSprite2D
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	if facing == "right":
		animated_sprite.flip_h = 1
	else:
		animated_sprite.flip_h = 0

func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animated_sprite.play("idle")
	if(direction == "left"):
		animated_sprite.flip_h = 1

static func stop_player() -> void:
	move = false
	
static func resume_player() -> void:
	move = true

static func get_player_position_x() -> int:
	if player:
		return player.global_position[0]
	else:
		return 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move:
		var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
		velocity = direction * speed
		move_and_slide()
		if velocity.length_squared() == 0:
			animated_sprite.play("idle")
			if foot_step.playing:
				foot_step.stop()
		else:
			animated_sprite.play("walk")
			if !foot_step.playing:
				foot_step.play()
		
		if(direction.x > 0): animated_sprite.flip_h = 1
		if(direction.x < 0): animated_sprite.flip_h = 0
	else:
		foot_step.stop()
		animated_sprite.play("idle")
