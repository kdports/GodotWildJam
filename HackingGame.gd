extends Node2D


var red_obtained
var yellow_obtained
var green_obtained
var end_reached

onready var player = $PlayerBox
onready var camera = $Viewport/Camera2D
onready var red = $RedStar
onready var yellow = $YellowCircle
onready var green = $GreenTriangle
onready var end = $Ending
onready var edges = $Edges
var starting_player_pos
var arrangement = GlobalVariables.arrangement
var lives = GlobalVariables.hacking_lives

var config1 = preload("res://config1.tscn")
var config2 = preload("res://config2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	red_obtained = 0
	yellow_obtained = 0
	green_obtained = 0

	if arrangement == 0:
		# This could be done better, but it's good enough
		var tiles = config1.instance() # Change this to config2, etc.
		tiles.position = Vector2(-36, -28) # Keep this the same
		edges.add_child(tiles) # Keep same
		
		# Use ruler feature to find pixel difference between top left and goal
		player.position.x = 40
		player.position.y = 30
		red.position.x = 906
		red.position.y = 76
		yellow.position.x = 57
		yellow.position.y = 260
		green.position.x = 505
		green.position.y = 523
		end.position.x = 975
		end.position.y = 528
	elif arrangement == 1:
		var tiles = config2.instance() # Change this to config2, etc.
		tiles.position = Vector2(-36, -28) # Keep this the same
		edges.add_child(tiles) # Keep same
		
		# Use ruler feature to find pixel difference between top left and goal
		player.position.x = 40
		player.position.y = 60
		red.position.x = 104
		red.position.y = 492
		yellow.position.x = 165
		yellow.position.y = 170
		green.position.x = 900
		green.position.y = 456
		end.position.x = 430
		end.position.y = 386
	# Add future elif clauses for different arrangements
	
	starting_player_pos = [player.position.x, player.position.y]
	
#func _process(delta):
#	if player.position != null:
#		camera.position.x = player.position.x
#		camera.position.y = player.position.y
	
func _on_PlayerBox_body_entered(body):
	if body.type == "wall":
		print("WALL FAIL")
		hacking_failure()
		#Add a GUI call here

func _on_PlayerBox_area_entered(area):
	if area.type == "red":
		print(1)
		red_obtained = 1
		#Add a GUI call here
	if area.type == "yellow":
		print(2)
		yellow_obtained = 1
		#Add a GUI call here
	if area.type == "green":
		print(3)
		green_obtained = 1
		#Add a GUI call here
	if area.type == "end":
		print(4)
		if green_obtained and yellow_obtained and red_obtained:
			print("WIN")
			#Add a GUI call here
		else:
			print("FAIL")
			hacking_failure()

func hacking_failure():
	if lives > 0:
		player.position.x = starting_player_pos[0]
		player.position.y = starting_player_pos[1]
		player.dir = "r"
		lives -= 1
	else:
		player.queue_free()
