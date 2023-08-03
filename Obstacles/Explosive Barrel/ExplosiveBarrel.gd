extends StaticBody2D

var explosion_timer = 5
var health = 40
var attack = Attack.new()

var animated_flame = preload("res://Obstacles/Explosive Barrel/Animated Flame.tscn")

func _ready():
	attack.attack_damage = 75
	attack.knockback_force = 50

# checks for barrel takes damage
func take_damage(attack : Attack):
		#spawn flame at point of bullet
		#spawn_flame()
		health -= attack.attack_damage
		print("Barrel Took Damage : ", attack.attack_damage)
		if health <= 0:
			barrel_explosion()
			print("Barrel explosion")

func barrel_explosion():
	# spawn explosion animation, call damage to player/enemies in range
	# possible knockback force applied
	queue_free()
	pass
	
func spawn_flame():
	# spawns flame at attack location
	var flame_temp = animated_flame.instantiate()
	flame_temp.position = attack.attack_position
	# reverses directino of attack to make flame face away from barrel
	flame_temp.rotation = 360 - attack.attack_rotation
	get_tree().get_root().add_child(flame_temp)
	pass
