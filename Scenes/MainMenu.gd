extends Control



func _ready():
	$VBoxContainer/StartButton.grab_focus()
	

func _process(delta):
	if $MenuMusic.playing == false:
		$MenuMusic.play()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
