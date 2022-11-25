extends KinematicBody2D

export var bullet_speed = 2000
export var move_speed = 150
export var health = 100
var direction = Vector2.ZERO
var mag_size = 5
var fire_rate = 3

var player
var player_in_range = false

var can_move = true
var can_shoot = true
var is_shooting = false
var is_reloading = false

#loads bullet and gun flare
var bullet = preload("res://Player/PlayerBullet.tscn")
var gun_flare = preload("res://Player/PlayerGunFlare.tscn")

func _ready():
	var my_player_group = get_tree().get_nodes_in_group("player")
	for playerItem in my_player_group:
		player = playerItem

func _process(delta):
	# enemy movement function and attacking
	if player_in_range:
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
	#else if not is_reloading:
		# movement handling
		
#func shoot_weapon():
	# enemy firing handler
	
	
# detects if player comes within range of sniper (skips if body isn't player)
func _on_Area2D_body_entered(body):
	if body == player:
		print("player entered")
		player_in_range = true
	else:
		pass

# detects if player leaves range of enemy sniper (skips if not the player)
func _on_Area2D_body_exited(body):
	if body == player:
		print("player exited")
		player_in_range = true
	else:
		pass
	pass # Replace with function body.
