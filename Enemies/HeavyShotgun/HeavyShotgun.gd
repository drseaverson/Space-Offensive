extends EnemyParent
# inheritance form main enemy type
# inheritance currently in progress and needs more work/testing
# heavy needs personal bullets and gun flare depending on function


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_name = "Shotgunner"
	bullet = load("res://Bullets/Enemy/EnemyBullet.tscn")
	gun_flare = load("res://Bullets/Gun Flares/ShotgunFlare.tscn")
	fire_rate = 1.25
	health = 150
	health_bar.max_health_updated(health)
	print(enemy_name, " health updated to ", health)


#func shoot_weapon():
	#override shoot function to properly shoot shotgun and calculate randomness/bullets
