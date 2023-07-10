extends RigidBody2D
class_name Bullet

@export var time_offscreen = 1
@export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	# possible delay for bullets to last slightly unchecked screen
	queue_free()


func _on_BulletBase_body_entered(body):
	if !body.is_in_group("player"):
		#create instance of explosion
		if body.is_in_group("enemy"):
			# deals damage to enemy if of that type
			body.take_damage(damage)
		queue_free()
