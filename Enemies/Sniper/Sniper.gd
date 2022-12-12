extends EnemyParent
# inherites from main enemy class type 
# inheritance currently working properly for sniper
# small error to do with area2D entrance causing more firing (could be fixed with in range area and shooting area)


func _ready():
	# adjusts variables from parent class to match enemy type
	enemy_name = "Sniper"
	bullet = load("res://Bullets/Enemy/SniperBullet.tscn")
	bullet_speed = 1700
	fire_rate = 3
	shooting_delay = 0.75
	mag_size = 1
	health_bar.max_health_updated(health)
	print(enemy_name, " health updated to ", health)

"""func _process(delta):
	# enemy movement function and attacking
	if player_in_range and not is_shooting:
		# function for player in range
		look_at(player.position)
	else:
		# function for passive movement paths
		pass

# commented out to test proper parent inheritance
func _physics_process(delta):
	direction = Vector2.ZERO
	get_movement()
	#direction = move_and_slide(direction)

func shoot_weapon():
	# play sniper firing warmup sound
	# delay for sniper warmup
	yield(get_tree().create_timer(shooting_delay), "timeout")
	var bullet_temp = bullet.instance()
	bullet_temp.position = $BulletPoint.get_global_position()
	bullet_temp.rotation_degrees = rotation_degrees
	bullet_temp.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_temp)
	is_shooting = false
	#minor yield to display gun flare
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_shoot = true
	
	
# detects if player comes within range of sniper (skips if body isn't player)
func _on_ShootingRange_body_entered(body):
	if body == player:
		print("player entered")
		player_in_range = true
		yield(get_tree().create_timer(shooting_delay), "timeout")
		can_shoot = true
	else:
		pass

# detects if player leaves range of enemy sniper (skips if not the player)
func _on_ShootingRange_body_exited(body):
	if body == player:
		print("player exited")
		player_in_range = false
		roaming_movement()
	else:
		pass

func take_damage(damage):
	health -= damage
	print("Sniper Took Damage: ", damage)
	if health <= 0:
		# lock movement of character for death animation/explosion etc
		print("Sniper Died")
		is_dead = true
		queue_free()
		
func roaming_movement():
	#resets shooting ability for next player in range
	can_shoot = false
	# roaming for inactive movement (player out of range)"""

#func chasing_movement():
# chasing movement addition at later time to increase difficulty (enemies chase player)
