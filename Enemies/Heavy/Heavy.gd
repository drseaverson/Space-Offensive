extends Enemy
# inheritance form main enemy type
# inheritance currently in progress and needs more work/testing

# Called when the node enters the scene tree for the first time.
func _ready():
	# adjusts variables from parent class to match enemy type
	enemy_name = "Heavy"
	bullet = load("res://Bullets/Enemy/EnemyBullet.tscn")
	gun_flare = load("res://Bullets/Player/PlayerGunFlare.tscn")
	fire_rate = 0.50
	health = 150

#possible minigun for heavy (rng required for changes for proper minigun)
#func shoot_weapon():
	#pass

