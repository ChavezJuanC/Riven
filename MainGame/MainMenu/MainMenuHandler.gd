class_name MainMenu
extends Node2D

var UpperLevelScene :String = "res://MainGame/UpperLevel/UpperLevel.tscn"
@export var menu_music :AudioStreamPlayer

##Signals
func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file(UpperLevelScene)

func _on_exit_button_button_down() -> void:
	get_tree().quit()

func _on_settings_button_button_down() -> void:
	print("Opening Settings")
	##Go to settings Scene...

func _on_menu_music_handler_finished():
	menu_music.play()
