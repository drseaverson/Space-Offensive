extends StaticBody2D

var explosion_timer = 5
var health = 40
var attack = Attack.new()

func _ready():
	attack.attack_damage = 75
	attack.knockback_force = 50

# checks for barrel takes damage
func take_damage(attack : Attack):
		#spawn flame at point of bullet
		health -= attack.attack_damage
		print("Barrel Took Damage : ", attack.attack_damage)
		if health <= 0:
			barrel_explosion()
			print("Barrel explosion")

func barrel_explosion():
	# spawn epxlosion animation, call damage to player/enemies in range
	# possible knockback force applied
	queue_free()
	pass
