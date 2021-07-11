extends Camera2D

onready var player = $PlayerBox

func _process(delta):
	if player.position:
		position.x = player.position.x
		position.y = player.position.y
