extends CharacterBody2D
class_name FlareParent

var timer = 0.05


func _ready():
	$DestroyTimer.start(timer)


func _on_Timer_timeout():
	queue_free()
