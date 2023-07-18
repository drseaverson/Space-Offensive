extends Area2D
class_name Bullet

var max_range = 1250
var speed = 1000
var attack = Attack.new()
var travelled_distance = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	attack.attack_damage = 10
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var distance = speed * delta
	var motion = transform.x * speed * delta
	
	position += motion
	
	travelled_distance += distance
	if travelled_distance > max_range:
		queue_free()



func _on_body_entered(body):
	if !body.is_in_group("player"):
		#create instance of explosion
		if body.is_in_group("enemy") or body.is_in_group("obstacle"):
			# deals damage to enemy if of that type and gives position
			attack.position = global_position
			body.take_damage(attack)
		queue_free()
