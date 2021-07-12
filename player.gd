extends Area2D

export var MOVEMENT_CONSTANT = 160
var dm = GlobalVariables.dash_multiplier
var screen_size

# There's probably a better way to do this...
var RIGHT_ANIM_START = 0
var RIGHT_ANIM_END = 5
var UP_ANIM_START = 6
var UP_ANIM_END = 7

onready var sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite.animation = "default"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	dm = 1
	
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x = 5
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x = -5
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y = 5
	if Input.is_key_pressed(KEY_UP):
		velocity.y = -5

	if Input.is_key_pressed(KEY_SHIFT):
		dm = GlobalVariables.dash_multiplier

	position = position + velocity.normalized()*MOVEMENT_CONSTANT* \
		delta*dm
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		sprite.animation = "default"
		sprite.flip_v = false
		sprite.flip_h = velocity.x < 0
	elif velocity.y < 0:
		sprite.animation = "up"
		#$AnimatedSprite.flip_v = velocity.y > 0
	elif velocity.y < 0:
		#Replace later
		pass
	else:
		sprite.animation = "default"

	if velocity.normalized():
		sprite.play()
	else:
		sprite.stop()
