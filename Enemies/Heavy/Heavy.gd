extends KinematicBody2D

var direction = Vector2.ZERO

var player
var player_in_range = false
export var health = 150
var is_dead = false

var is_shooting = false
var can_move = true
var can_shoot = false
var is_reloading = false

# Called when the node enters the scene tree for the first time.
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

#conducts enemy movement
func _physics_process(delta):
	direction = Vector2.ZERO
	get_movement()
	#direction = move_and_slide(direction)
	
#handles and calculates enemy movement/actions
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

# detects when player enters shooting range of enemy
func _on_ShootingRange_body_entered(body):
	pass # Replace with function body.

#detects when player leaves shooting range of enemy
func _on_ShootingRange_body_exited(body):
	roaming_movement()
	#possible call to chasing movement with addition to in range of chase after leaving shooting range
	pass # Replace with function body.

func shoot_weapon():
	#method to handles weapon shooting
	pass

func take_damage(damage):
	health -= damage
	print("Heavy Took Damage: ", damage)
	if health <= 0:
		# lock movement of character for death animation/explosion etc
		print("Heavy Died")
		is_dead = true
		queue_free()

func roaming_movement():
	#resets shooting ability for next player in range
	can_shoot = false
	# roaming for inactive movement (player out of range/out of chasing range)
