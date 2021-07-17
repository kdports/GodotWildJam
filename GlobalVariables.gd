extends Node


# I've set this up to store information we need between scenes. Yay
var dash_multiplier = 8
var arrangement = 0
var hacking_lives = 3
var difficulty = 0

#Major gameplay stuff - affected by events and minigames
var fuelStart = 200
var scrapStart = 1
var distStart = 90
var fuel = fuelStart
var scrap = scrapStart
var dist = distStart

#Event stuff - tracks what stage the player is in. 
#Counts up from 0 (the starting position) to 10 (Mars, the destination). Negative values represent a fail state/ game over
var travelStart = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
