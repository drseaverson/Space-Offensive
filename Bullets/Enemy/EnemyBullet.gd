extends Bullet



# Called when the node enters the scene tree for the first time.
func _ready():
	attack.attack_damage = 5


func _on_EnemyBullet_body_entered(body):
	if !body.is_in_group("enemy"):
		#create instance of explosion
		if body.is_in_group("player"):
			# deals damage to enemy if of that type
			body.take_damage(attack)
		queue_free()
