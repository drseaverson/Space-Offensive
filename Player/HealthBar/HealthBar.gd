extends Control

onready var health_bar = $HealthBar

func on_health_updated(health, amount):
	health_bar.value = health

func max_health_updated(max_health):
	health_bar.max_value = max_health
	on_health_updated(max_health, 0)

# update process to properly display health bar above enemy at all times
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

