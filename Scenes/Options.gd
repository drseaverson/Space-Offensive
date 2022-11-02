extends Control

#gets audio channels to change overall/specific volumes
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var effects_bus = AudioServer.get_bus_index("Effects")
export var master_music_value = -5
export var effects_music_value = 0
export var music_value = 0

#sets values of all saved settings
func _ready():
	get_node("VBoxContainer/MasterVolume").value = master_music_value
	get_node("VBoxContainer/EffectsVolume").value = effects_music_value
	get_node("VBoxContainer/MusicVolume").value = music_value

func _process(delta):
	if $MenuMusic.playing == false:
		$MenuMusic.play()

func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	master_music_value = value
	
	#mutes audio if slider is at min
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)

func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	music_value = value
	
	if value == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)

func _on_EffectsVolume_value_changed(value):
	AudioServer.set_bus_volume_db(effects_bus, value)
	effects_music_value = value
	
	if value == -30:
		AudioServer.set_bus_mute(effects_bus, true)
	else:
		AudioServer.set_bus_mute(effects_bus, false)

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

