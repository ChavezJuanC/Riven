class_name HealthPotion
extends Node2D

var player_body : CharacterBody2D
var in_potion_range :bool
var main_char_path :String = "UpperLevel/MainCharacter"
var potion_type :String;
var spawn_sound_played : bool = false;

@export var red_potion_sprite :Texture2D
@export var green_potion_sprite :Texture2D
@export var potion_sprite :Sprite2D
@export var spawn_sound :AudioStreamPlayer;
@export var collect_sound :AudioStreamPlayer

func _ready() -> void:
	##this would be a would place to choose a potion type and set the correct sprite bassed on potion type
	call_deferred("connect_signal")
	in_potion_range = true
	var randomFloat = randf_range(0,1)
	if randomFloat >= 0.6:
		potion_sprite.texture = green_potion_sprite
		potion_type = "speed"
	elif randomFloat < 0.6:
		potion_sprite.texture = red_potion_sprite
		potion_type = "health"

func connect_signal() -> void:
	var main_character = get_tree().root.get_node(main_char_path)
	if main_character:
		main_character.connect("Looting", on_main_char_looting)

func _process(_delta) -> void:
	pass

func on_main_char_looting() -> void :
	if in_potion_range:
		GlobalGameHandler.add_potion(potion_type);
		collect_sound.play()

func _on_area_2d_body_entered(body) -> void:
	if body is MainCharacter:
		player_body = body
		in_potion_range = true
		if !spawn_sound_played:
			spawn_sound.play()
			spawn_sound_played = true

func _on_area_2d_body_exited(body) -> void:
	if body is MainCharacter:
		player_body = body
		in_potion_range = false

func _on_collect_sound_finished():
	queue_free()
