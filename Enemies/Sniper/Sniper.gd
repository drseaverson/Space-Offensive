extends KinematicBody2D

export var bullet_speed = 1500
export var move_speed = 150
export var health = 100
var direction = Vector2.ZERO
var mag_size = 5
var fire_rate = 3
var shooting_delay = 0.75

var is_dead = false
var player
var player_in_range = false

var can_move = true
var can_shoot = false
var is_shooting = false
var is_reloading = false

#loads bullet and gun flare
var bullet = preload("res://Enemies/Sniper/SniperBullet.tscn")
# preload gun flare/warmup for shot being fired
# var gun_flare = preload("res://Player/PlayerGunFlare.tscn")

func _ready():
	var my_player_group = get_tree().get_nodes_in_group("player")
	for playerItem in my_player_group:
		player = playerItem

func _process(delta):
	# enemy movement function and attacking
	if player_in_range and not is_shooting:
		# function for player in range
		look_at(player.position)
	else:
		# function for passive movement paths
		pass
	
	
func _physics_process(delta):
	direction = Vector2.ZERO
	get_movement()
	#direction = move_and_slide(direction)

func get_movement():
	# create and manages enemy movement based on player movement (still while firing
	if is_shooting:
		return
	if player_in_range and can_shoot:
		can_shoot = false
		# stops movement of enemy
		direction = Vector2.ZERO
		is_shooting = true
		shoot_weapon()
	#else if not is_reloading:
		# movement handling
		
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
	# roaming for inactive movement (player out of range)

#func chasing_movement():
# chasing movement addition at later time to increase difficulty (enemies chase player)
