extends Area2D


var type


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_enemy_area_entered(area):
	if area.type and area.type == "bullet":
		self.queue_free()
