extends Pickup

@export var health_amount = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if (body.is_in_group("player")):
		body.add_health(health_amount, "health")
