extends KinematicBody2D
# explosion radius needs testing
# possible introduction of larger damage output the closer you are to the grenade
# possible stun/knockback from grenade? 
var time_left = 1.5
var explosion_damage = 25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# create timer for explosion for destruction of object after timer finishes
	pass
	

func _on_Area2D_body_entered(body):
	print("Body Detected within Blast Radius")
	# deal damage to each body within explosion properly
	pass # Replace with function body.
