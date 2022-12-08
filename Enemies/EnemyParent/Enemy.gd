extends KinematicBody2D
class_name Enemy

const move_speed = 150
export var health = 100
export var bullet_speed = 1500
export var mag_size = 5
export var fire_rate = 3
export var shooting_delay = 0

var enemy_name = null
var direction = Vector2.ZERO
var is_dead = false
var player
var player_in_range = false
var can_move = true
var can_shoot = false
var is_shooting = false
var is_reloading = false
var gun_flare = null
var bullet = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var my_player_group = get_tree().get_nodes_in_group("player")
	for playerItem in my_player_group:
		player = playerItem

func _physics_process(delta):
	direction = Vector2.ZERO
	get_movement()
	#direction = move_and_slide(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range and not is_shooting:
		# function for player in range
		look_at(player.position)
	else:
		# function for passive movement paths
		pass

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
		

# detects when player enters the shooting range of enemy
func _on_ShootingRange_body_entered(body):
	if body == player:
		print("player entered")
		player_in_range = true
		yield(get_tree().create_timer(shooting_delay), "timeout")
		can_shoot = true
	else:
		pass

func _on_ShootingRange_body_exited(body):
	if body == player:
		print("player exited")
		player_in_range = false
		roaming_movement()
	else:
		pass

func shoot_weapon():
	# play sniper firing warmup sound
	# create gun flare statement and display
	# delay for weapon warmup if enemy has shooting delay (sniper)
	if bullet != null:
		var bullet_temp = bullet.instance()
		bullet_temp.position = $BulletPoint.get_global_position()
		bullet_temp.rotation_degrees = rotation_degrees
		bullet_temp.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_temp)
		is_shooting = false
		#minor yield to display gun flare
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_shoot = true

# tracks enemy damage/health
func take_damage(damage):
	health -= damage
	print(enemy_name, " Took Damage: ", damage)
	if health <= 0:
		# lock movement of character for death animation/explosion etc
		print(enemy_name, " Died")
		is_dead = true
		queue_free()
		
func roaming_movement():
	#resets shooting ability for next player in range
	can_shoot = false
	# roaming for inactive movement (player out of range)


