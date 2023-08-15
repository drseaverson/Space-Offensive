extends Sprite2D

#explosion animation automatically called once ready

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "barrel_explosion"):
		print("Barrel animation finished")
		queue_free()
