extends KinematicBody2D

#player value handlers
export var move_speed = 250
export var bullet_speed = 1375
export var fire_rate = 0.50
var gun_flare_rate = 0.05
export var player_health = 100


#loads bullet and gun flare
var bullet = preload("res://Player/PlayerBullet.tscn")
var gun_flare = preload("res://Player/PlayerGunFlare.tscn")
var rng = RandomNumberGenerator.new()
var can_shoot = true


func _process(delta):
	look_at(get_global_mouse_position())
	
	#intializes shot and delay before next shot can be taken
	if (Input.is_action_pressed("shoot_primary")) and can_shoot:
		can_shoot = false
		#set animation for player shoot pistol
		_player_shoot()
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_shoot = true

#player movement management
func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y -= 1.0
	if Input.is_action_pressed("move_down"):
		direction.y += 1.0
	if Input.is_action_pressed("move_left"):
		direction.x -= 1.0
	if Input.is_action_pressed("move_right"):
		direction.x += 1.0
	#controls diagonal movement normalization
	direction = direction.normalized()
	move_and_slide(direction * move_speed)


func _player_shoot():
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
