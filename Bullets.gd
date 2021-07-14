extends Node2D

const bullet_image = preload("res://bullet.png")

var bullets = []
var shape

class Bullet:
	var position = Vector2()
	var speed = 1.0
	var body = RID()

func _ready():
	shape = Physics2DServer.circle_shape_create()
	# Set the collision shape's radius for each bullet in pixels.
	Physics2DServer.shape_set_data(shape, 8)

func _process(_delta):
	update()
	
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		var bullet = Bullet.new()
		bullet.speed = 50
		bullet.body = Physics2DServer.body_create()

		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)

		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		if $ShootingGame.player:
			bullet.position = player.get_position()
		else:
			bullet.position = Vector2(0, 0)
		var transform2d = Transform2D()
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		bullets.push_back(bullet)

func _physics_process(_delta):
	var transform2d = Transform2D()
	var offset = get_viewport_rect().size.x + 16
	for bullet in bullets:
		# bullet.position.x -= bullet.speed * delta
		# Change

		if bullet.position.x < -16 or bullet.position.x > offset or  \
				bullet.position.y < -16 or bullet.position.y > get_viewport_rect().size.y:
			Physics2DServer.free_rid(bullet.body)
			bullets.erase(bullet)

		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)
		
func _draw():
	var offset = -bullet_image.get_size() * 0.5
	for bullet in bullets:
		draw_texture(bullet_image, bullet.position + offset)
		
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	Physics2DServer.free_rid(shape)
	bullets.clear()
