class_name Mushroom
extends Node2D

var in_loot_reach :bool
@onready var main_character = $"../../../MainCharacter"
@export var mushroom_collect_sound: AudioStreamPlayer;
@onready var inventory_button = $"../../../UI/InventoryButton"

func _ready() -> void :
	in_loot_reach = false
	main_character.connect("Looting", _on_player_looting)

func _on_area_2d_body_entered(body) -> void :
	if body is MainCharacter:
		in_loot_reach = true

func _on_player_looting() -> void :
	if in_loot_reach:
		GlobalGameHandler.shroom_collected()
		mushroom_collect_sound.play()
		inventory_button.populate_ui()

func _on_area_2d_body_exited(body) -> void :
	if body is MainCharacter:
		in_loot_reach = false

func _on_mushroom_collect_sound_finished():
	queue_free()
