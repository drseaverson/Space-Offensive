extends Area2D
class_name Pickup

@export var pickup_timer = 10
#possible use of type classification wihtin parent instead of in child

func _ready():
	#declare any variables etc as needed when created?
	pass

func _flicker_start(timer):
	pass

#removes pickup from map once timer expires
func _timer_up():
	queue_free()

#func to add health or other bonus to player
#func _add_health(health_amount):
	#pass
