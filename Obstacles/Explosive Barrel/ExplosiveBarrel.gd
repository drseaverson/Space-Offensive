extends StaticBody2D

var explosion_timer = 5
var health = 40
var attack = Attack.new()
var blink = false

var animated_flame = preload("res://Obstacles/Explosive Barrel/Animated Flame.tscn")
var animated_explosion = preload("res://Obstacles/Explosive Barrel/Barrel_Explosion.tscn")

func _ready():
	attack.attack_damage = 50
	attack.knockback_force = 50

# checks for barrel takes damage
func take_damage(damage : Attack):
	if (!blink):
		blink = true
		$ExplosionTimer.start()
	#spawn flame at point of bullet
	#spawn_flame(damage)
	health -= damage.attack_damage
	print("Barrel Took Damage : ", damage.attack_damage)
	if health <= 0:
		barrel_explosion()
		print("Barrel explosion")

func barrel_explosion():
	# spawns explosion animation
	var explosion_temp = animated_explosion.instantiate()
	explosion_temp.position = position
	get_tree().get_root().add_child(explosion_temp)
	$Explosion.play()
	# makes sprite invisible and unable to collide while sound plays
	$Sprite2D.visible = false
	get_node("Collision").set_deferred("disabled", true)
	# gets all bodies within explosive area
	var bodies : Array = $ExplosiveArea2D.get_overlapping_bodies()
	if !bodies.is_empty():
		for body in bodies:
			if body.is_in_group("player") or body.is_in_group("enemy"):
				# calls damage function and applies knockback to players
				# general knockback direction function (variable is held in Attack class)
				# var heading = (b.global_transform.origin - a.global_transform.origin).normalized()
				body.take_damage(attack)
	# spawn explosion animation
	await get_tree().create_timer(2).timeout
	queue_free()
	
func spawn_flame(damage : Attack):
	# spawns flame at attack location
	var flame_temp = animated_flame.instantiate()
	flame_temp.position = damage.attack_position
	# reverses direction of attack to make flame face away from barrel
	flame_temp.rotation_degrees = (180 - abs(damage.attack_rotation)) - 90
	get_tree().get_root().add_child(flame_temp)

func _on_explosion_timer_timeout():
	barrel_explosion()
