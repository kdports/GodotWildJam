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
var starting_player_pos
var arrangement = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	red_obtained = 0
	yellow_obtained = 0
	green_obtained = 0
	
	starting_player_pos = [player.position.x, player.position.y]
	#Test case please ignore
	#if arrangement == 0:
	#	player.position.y = 100
	
func _process(delta):
	camera.position.x = player.position.x
	camera.position.y = player.position.y

func _on_PlayerBox_area_entered(area):
	if area.type == "wall":
		print("FAIL")
		hacking_failure()
		#Add a GUI call here
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
	player.position.x = starting_player_pos[0]
	player.position.y = starting_player_pos[1]
	player.dir = "r"
