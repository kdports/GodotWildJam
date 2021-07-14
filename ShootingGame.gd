extends Node2D

var difficulty = GlobalVariables.difficulty
var rng = RandomNumberGenerator.new()
onready var player = $Player
onready var fuel = $Fuel
onready var f_pos = fuel.get_position()
var spawn_locations = {
	0: [240, -27],
	1: [900, -31],
	2: [1101, 123],
	3: [1200, 500],
	4: [930, 620],
	5: [130, 605],
	6: [-50, 70],
	7: [-60, 442]
}
var all_enemies = []
var all_projectiles = []

var bullet = preload("res://Bullet.tscn")

var enemy1 = preload("res://enemy1.tscn")
var enemy_list = [enemy1]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Creates initial enemies
	spawn_enemies()
	
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		var b = bullet.instance()
		add_child(b)
		b.position = player.get_position()
		
		var x_speed = 0
		var y_speed = 0
		x_speed = (event.position.x - b.position.x)/50
		y_speed = (event.position.y - b.position.y)/50
		all_projectiles.append([b, x_speed, y_speed])
	
func _process(_delta):
	# Moves the enemies closer to fuel
	for p in all_projectiles:
		p[0].position.x += p[1]
		p[0].position.y += p[2]
	for e in all_enemies:
		e[0].position.x += e[1]
		e[0].position.y += e[2]
	
func spawn_enemies():
	rng.randomize()
	
	var to_spawn = 0
	if difficulty == 0:
		to_spawn += rng.randi_range(1, 3)
	elif difficulty == 1:
		to_spawn += rng.randi_range(2, 5)
	elif difficulty == 2:
		to_spawn += rng.randi_range(4, 7)
	
	var i = 0
	var next_enemy
	var spawn_choice = enemy_list.duplicate()
	while i < to_spawn:
		# Chooses a random enemy and creates 
		spawn_choice.shuffle()
		next_enemy = spawn_choice[0].instance()
		var x_speed = 0
		var y_speed = 0
		add_child(next_enemy)
		
		# Chooses a random position
		var ii = rng.randi_range(0, spawn_locations.size() - 1) # Random location
		var xspawn = spawn_locations[ii][0]
		var yspawn = spawn_locations[ii][1]
		if spawn_locations[ii][0] > get_viewport_rect().size.x or \
				spawn_locations[ii][0] < 0:
			yspawn += rng.randi_range(-75, 75) # Prevents multiple spawning on same pixel
		if spawn_locations[ii][1] > get_viewport_rect().size.y or \
				spawn_locations[ii][1] < 0:
			xspawn += rng.randi_range(-75, 75) # Prevents multiple spawning on same pixel
		next_enemy.position = Vector2(xspawn, yspawn)
		next_enemy.look_at(fuel.position)
		
		# Determines relative location
		x_speed = (f_pos[0] - next_enemy.position.x)/250
		y_speed = (f_pos[1] - next_enemy.position.y)/250
		
		all_enemies.append([next_enemy, x_speed, y_speed])
		i += 1

func _on_Fuel_area_entered(area):
	if area != player and area.type != "bullet":
		player.queue_free()
		fuel.queue_free()
