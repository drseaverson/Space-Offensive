extends Bullet


# Called when the node enters the scene tree for the first time.
func _ready():
	attack.attack_damage = 50
	attack.knockback_force = 1000
	speed = 500
	max_range = 750 # decreased range and explodes after short bit at max range
	$ExplosionTimer.start()

func grenade_explosion():
	attack.attack_position = global_position
	#body.take_damage(attack)
	pass

# detects if grenade direct impacts player
func _on_Grenade_body_entered(body):
	if !body.is_in_group("enemy"):
		#create instance of explosion
		if body.is_in_group("player"):
			# deals damage to enemy if of that type
			grenade_explosion()
		queue_free()


func _on_explosion_timer_timeout():
	grenade_explosion()
