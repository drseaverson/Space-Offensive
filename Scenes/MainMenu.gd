extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	if MusicController.is_playing() == false:
		MusicController.play_music()
	

func _process(delta):
	if MusicController.is_playing() == false:
		MusicController.play_music()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
