extends Node2D

var target = load("res://Sprites/Cursors/red_target.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	#stops menu music if it is still playing
	if MusicController.is_playing():
		MusicController.stop_music()
	#changes cursor to target cursor checked game start
	Input.set_custom_mouse_cursor(target, Input.CURSOR_ARROW, Vector2(20, 20)) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
