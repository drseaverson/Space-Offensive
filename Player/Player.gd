extends KinematicBody2D

export var move_speed = 250
export var bullet_speed = 1375
export var fire_rate = 0.09
export var player_health = 100

var bullet = preload("res://Player/PlayerBullet.tscn")
var gun_flare = preload("res://Player/PlayerGunFlare.tscn")
var rng = RandomNumberGenerator.new()
var can_shoot = true


func _process(delta):
	look_at(get_global_mouse_position())
		
	# primary bullet/gun flare handler
	if (Input.is_action_pressed("shoot_primary")) and can_shoot:
		rng.randomize()
		var random_num = rng.randf_range(-5, 5)
		var bullet_temp = bullet.instance()
		var gun_flare_temp = gun_flare.instance() 
		gun_flare_temp.position = $BulletPoint.get_global_position()
		gun_flare_temp.rotation_degrees = rotation_degrees
		get_tree().get_root().add_child(gun_flare_temp)
		bullet_temp.position = $BulletPoint.get_global_position()
		bullet_temp.rotation_degrees = rotation_degrees
		bullet_temp.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_temp)
		can_shoot = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		gun_flare_temp.queue_free()
		can_shoot = true
	

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
	direction = direction.normalized()
	move_and_slide(direction * move_speed)
