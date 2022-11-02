extends Control

#gets audio channels to change overall/specific volumes
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var effects_bus = AudioServer.get_bus_index("Effects")

func _process(delta):
	if $MenuMusic.playing == false:
		$MenuMusic.play()

func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	#mutes audio if slider is at min
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)

func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)

func _on_EffectsVolume_value_changed(value):
	AudioServer.set_bus_volume_db(effects_bus, value)

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

