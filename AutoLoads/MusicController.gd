extends Node

var menu_music = load("res://Sounds/Music/menuMusic.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_music():
	$MenuMusic.stream = menu_music
	$MenuMusic.play()
	
func stop_music():
	if $MenuMusic.playing:
		$MenuMusic.stop()
	
func is_playing():
	return $MenuMusic.playing
	

