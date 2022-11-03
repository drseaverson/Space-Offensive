extends KinematicBody2D

#player value handlers
export var move_speed = 250
export var bullet_speed = 1500
export var fire_rate = 0.25
var gun_flare_rate = 0.05
export var player_health = 100
export var pistol_mag_size = 12


#loads bullet and gun flare
var bullet = preload("res://Player/PlayerBullet.tscn")
var gun_flare = preload("res://Player/PlayerGunFlare.tscn")
#var rng = RandomNumberGenerator.new() random number generator (if needed)
var can_shoot = true
var can_melee = true
var is_reloading = false
var is_shooting = false


func _process(delta):
	look_at(get_global_mouse_position())
	
	#intializes shot and delay before next shot can be taken
	if Input.is_action_just_pressed("shoot_primary") and can_shoot and pistol_mag_size > 0:
		can_shoot = false
		is_shooting = true
		#set animation for player shoot pistol
		_player_shoot()
		is_shooting = false
		pistol_mag_size -= 1;
		yield(get_tree().create_timer(fire_rate), "timeout")
		$AnimatedSprite.animation = "Player_Move_Pistol"
		can_shoot = true
	elif Input.is_action_just_pressed("shoot_primary") and can_shoot:
		$OutOfAmmo.play()
		
	if Input.is_action_just_pressed("reload") and pistol_mag_size < 12:
		is_reloading = true
		$AnimatedSprite.animation = "Player_Reload_Pistol"
		yield(get_tree().create_timer(1.4), "timeout")
		pistol_mag_size = 12
		is_reloading = false

#player movement management
func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		if !is_reloading and !is_shooting:
			$AnimatedSprite.animation = "Player_Move_Pistol"
		direction.y -= 1.0
	if Input.is_action_pressed("move_down"):
		if !is_reloading and !is_shooting:
			$AnimatedSprite.animation = "Player_Move_Pistol"
		direction.y += 1.0
	if Input.is_action_pressed("move_left"):
		if !is_reloading and !is_shooting:
			$AnimatedSprite.animation = "Player_Move_Pistol"
		direction.x -= 1.0
	if Input.is_action_pressed("move_right"):
		if !is_reloading and !is_shooting:
			$AnimatedSprite.animation = "Player_Move_Pistol"
		direction.x += 1.0
	
	#resets player animation to idle when not moving/shooting
	if (Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_left")) and can_shoot and can_melee and !is_reloading:
		$AnimatedSprite.animation = "Player_Idle_Pistol"
	#controls diagonal movement normalization
	direction = direction.normalized()
	move_and_slide(direction * move_speed)


func _player_shoot():
	$Pistol.play()
	$AnimatedSprite.animation = "Player_Shoot_Pistol"
	var bullet_temp = bullet.instance()
	var gun_flare_temp = gun_flare.instance() 
	gun_flare_temp.position = $BulletPoint.get_global_position()
	gun_flare_temp.rotation_degrees = rotation_degrees
	get_tree().get_root().add_child(gun_flare_temp)
	bullet_temp.position = $BulletPoint.get_global_position()
	bullet_temp.rotation_degrees = rotation_degrees
	bullet_temp.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_temp)
	#minor yield to display gun flare
	yield(get_tree().create_timer(gun_flare_rate), "timeout")
	gun_flare_temp.queue_free()
