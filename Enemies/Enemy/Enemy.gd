extends EnemyParent


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_name = "Soldier"
	bullet = load("res://Bullets/Enemy/EnemyBullet.tscn")
	gun_flare = load("res://Bullets/Player/PlayerGunFlare.tscn")
	fire_rate = 1
	mag_size = 12
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
