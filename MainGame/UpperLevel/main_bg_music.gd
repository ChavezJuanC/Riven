class_name music_handler
extends AudioStreamPlayer

@export var main_music_loop :AudioStreamPlayer

func _on_finished():
	main_music_loop.play()
