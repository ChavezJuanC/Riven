class_name BaseHandler
extends StaticBody2D

var in_loot_range :bool
@export var base_animator :AnimationPlayer
@onready var main_character = $"../../../MainCharacter"

@export var potion :PackedScene
@export var base_sprite: Sprite2D
@export var barrel_break_sound: AudioStreamPlayer;

func _ready() -> void :
	in_loot_range = false
	main_character.connect("Looting", _on_main_character_looting)

func _on_area_2d_body_entered(body) -> void :
	if body is MainCharacter:
		in_loot_range = true

func _on_area_2d_body_exited(body) -> void :
	if body is MainCharacter:
		in_loot_range = false

func _on_main_character_looting() -> void :
	if in_loot_range:
		base_animator.play("Break")
		barrel_break_sound.play()

func new_potion_on_screen() -> void :
	var potion_instance
	potion_instance = potion.instantiate()
	potion_instance.position = position
	# Reparent to the scene root to prevent it from being free by queue_free()
	get_tree().root.add_child(potion_instance)

func _on_animation_player_animation_finished(anim_name) -> void :
	if anim_name == "Break":
		var randFloat :float = randf_range(0,1)
		if randFloat > 0.6:
			new_potion_on_screen()
		queue_free()
		
