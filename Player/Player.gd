extends CharacterBody2D

#create function for picking up weapons to change animation trees (create alike names of animations for each tree to smoothly transfer
#implement functions to handle damage bonuses etc from pickups

#player value handlers
@export var move_speed = 250
@export var fire_rate = 0.20
var gun_flare_rate = 0.05
var reload_rate = 1.25
@export var player_health = 100
@export var max_health = 100
@export var shield_health = 50
@export var max_shield = 100
@export var pistol_mag_size = 12
var state_machine
var direction = Vector2.ZERO


#loads bullet and gun flare
var bullet = preload("res://Bullets/Player/PlayerBullet.tscn")
var gun_flare = preload("res://Bullets/Gun Flares/PlayerGunFlare.tscn")
#var rng = RandomNumberGenerator.new() random number generator (if needed)
var can_shoot = true
var can_melee = true
var is_reloading = false
var is_shooting = false
var is_melee = false
var dead = false

func _ready():
	#grabs state machine instance to manage animations for player
	state_machine = $AnimationTree.get("parameters/playback")

func _process(delta):
	look_at(get_global_mouse_position())
	

#player movement management
func _physics_process(delta):
	get_input()
	set_velocity(direction)
	move_and_slide()
	direction = velocity
	
func get_input():
	direction = Vector2.ZERO
	if Input.is_action_just_pressed("shoot_primary") and can_shoot and pistol_mag_size > 0 and not is_reloading:
		can_shoot = false
		is_shooting = true
		_player_shoot()
		is_shooting = false
		pistol_mag_size -= 1;
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true
		#returns early to not change animation unintentionally
		return
	elif Input.is_action_just_pressed("shoot_primary") and can_shoot:
		$OutOfAmmo.play()
	if Input.is_action_just_pressed("reload") and pistol_mag_size < 12:
		is_reloading = true
		state_machine.travel("Player_Reload_Pistol")
		pistol_mag_size = 12
		await get_tree().create_timer(reload_rate).timeout
		is_reloading = false
		return
	if Input.is_action_pressed("move_up"):
		direction.y -= 1.0
	if Input.is_action_pressed("move_down"):
		direction.y += 1.0
	if Input.is_action_pressed("move_left"):
		direction.x -= 1.0
	if Input.is_action_pressed("move_right"):
		direction.x += 1.0
	
	#controls diagonal movement normalization
	direction = direction.normalized() * move_speed
	if direction.length() == 0:
		state_machine.travel("Player_Idle_Pistol")
	if direction.length() > 0:
		state_machine.travel("Player_Move_Pistol")


func _player_shoot():
	$Pistol.play()
	state_machine.travel("Player_Shoot_Pistol")
	var bullet_temp = bullet.instantiate()
	var gun_flare_temp = gun_flare.instantiate() 
	gun_flare_temp.position = $BulletPoint.get_global_position()
	gun_flare_temp.rotation_degrees = rotation_degrees
	get_tree().get_root().add_child(gun_flare_temp)
	bullet_temp.position = $BulletPoint.get_global_position()
	bullet_temp.rotation_degrees = rotation_degrees
	get_tree().get_root().add_child(bullet_temp)
	
#set_physics_process(false) when player dies so you can't move
func take_damage(attack : Attack):
	if (attack.attack_damage >= 50):
		print("Knockback Force Applied: ", attack.knockback_force)
		set_velocity((global_position - attack.attack_position).normalized() * attack.knockback_force)
		move_and_slide()
		$TakeDamage2.play()
	else:
		$TakeDamage1.play()
	player_health -= attack.attack_damage
	print("Player Took Damage: ", attack.attack_damage)
	if player_health <= 0:
		# lock movement for death animation/explosion
		dead = true

#adds health/shield based on type given
func _add_health(health_amount, type):
	if (type == "health"):
		player_health += health_amount
		print("Player Gained " + health_amount + " health")
		if (player_health > max_health):
			player_health = max_health
	elif (type == "shield"):
		shield_health += health_amount
		print("Player Gained " + health_amount + " shield")
		if (shield_health > max_shield):
			shield_health = max_shield
	#play health gain sound/animation

