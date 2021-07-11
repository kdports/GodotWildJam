extends Area2D

export var MOVEMENT_CONSTANT = 170
var screen_size
var dir
var dir_dict = {
	"r": [1, 0],
	"l": [-1, 0],
	"u": [0, -1],
	"d": [0, 1]
}

onready var sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite.animation = "default"
	dir = "r"
	
func _process(delta):
	var velocity = Vector2()
	
	if Input.is_key_pressed(KEY_RIGHT) and dir != "l":
		dir = "r"
	elif Input.is_key_pressed(KEY_LEFT) and dir != "r":
		dir = "l"
	elif Input.is_key_pressed(KEY_DOWN) and dir != "u":
		dir = "d"
	elif Input.is_key_pressed(KEY_UP) and dir != "d":
		dir = "u"
		
	velocity.x = dir_dict[dir][0]
	velocity.y = dir_dict[dir][1]
	
	position = position + velocity.normalized()*MOVEMENT_CONSTANT* \
		delta
	
	if position.x < 0 or position.x > screen_size.x:
		# Add fail state here
		print("FAIL")
	elif position.y < 0 or position.y > screen_size.y:
		# Add fail state here
		print("FAIL")
