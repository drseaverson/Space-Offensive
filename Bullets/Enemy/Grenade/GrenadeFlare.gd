extends KinematicBody2D

var timer = 0.5

# function is called every frame to properly calculate timer for destruction
func _process(delta):
	# create timer to proper destroy flare of weapon in scene (futuer issue with multiple enemies using same flare)
	pass
