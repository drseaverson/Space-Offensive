extends RigidBody2D

var damage = 20

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	print()
	queue_free() #destroys self on exit of viewport


func _on_SniperBullet_body_entered(body):
	# deals damage to player based on bullet damage
	if body.is_in_group("player"):
		print("Collided with Player")
		body.take_damage(damage)
		queue_free()
	else:
		queue_free()
