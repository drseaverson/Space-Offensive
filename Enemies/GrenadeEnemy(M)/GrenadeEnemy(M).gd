extends EnemyParent
# inherites from main enemy class type 
# inheritance needs adjustment and proper method ovveriding to include rocket launchers on shoulder
# no current errors as methods have not been created/tested


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_name = "Grenader(M)"
	bullet = load("res://Bullets/Enemy/Grenade/Grenade.tscn")
	gun_flare = load("res://Bullets/Gun Flares/GrenadeFlare.tscn")
	bullet_speed = 750
	fire_rate = 4
	health = 200
	health_bar.max_health_updated(health)
	print(enemy_name, " health updated to ", health)
	# add in proper varibale differences from parent enemy

#func fire_rocket():
	# fire rocket, with proper timing and implementation for major enemy
	# create timer and other variables to track rocket launching, when it can launch, and in process etc
