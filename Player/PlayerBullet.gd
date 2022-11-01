extends RigidBody2D

#create function to destroy object once it has left the screen

func _on_PlayerBullet_body_entered(body):
	if !body.is_in_group("player"):
		#create instance of explosion
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	print("Exit Screen Activated")
	queue_free()
