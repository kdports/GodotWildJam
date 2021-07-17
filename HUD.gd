extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fuel
var scrap
var dist
onready var Flabel = $TextureRect/Flabel
onready var Slabel = $TextureRect/Slabel
onready var Dlabel = $TextureRect/Dlabel
# Called when the node enters the scene tree for the first time.
func _ready():
	fuel = GlobalVariables.fuel
	scrap = GlobalVariables.scrap
	dist = GlobalVariables.dist
	
	Flabel.text = str(fuel)
	Slabel.text = str(scrap)
	Dlabel.text = str(dist)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
