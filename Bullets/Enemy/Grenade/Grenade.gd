extends Bullet


# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 50
	speed = 500
	max_range = 750 # decreased range and explodes after short bit at max range


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Grenade_body_entered(body):
	if !body.is_in_group("enemy"):
		#create instance of explosion
		if body.is_in_group("player"):
			# deals damage to enemy if of that type
			body.take_damage(damage)
		queue_free()
