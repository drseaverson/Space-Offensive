extends RigidBody2D

var time_offscreen = 1
var damage = 10

#create function to destroy object once it has left the screen

func _on_PlayerBullet_body_entered(body):
	if !body.is_in_group("player"):
		#create instance of explosion
		if body.is_in_group("enemy"):
			# deals damage to enemy if of that type
			body.take_damage(damage)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	# timeout to let bullet last longer off screen to shoot at enemies off screen
	yield(get_tree().create_timer(time_offscreen), "timeout")
	queue_free()
