class_name AK47;
extends Area2D;

var in_loot_range :bool;
@export var item_collect_sound :AudioStreamPlayer
@onready var inventory_button = $"../../UI/InventoryButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	in_loot_range = false;

func _on_main_character_looting() -> void:
	if in_loot_range:
		GlobalGameHandler.Weapon_Collected("Ak-47");
		inventory_button.populate_ui()
		item_collect_sound.play();

func _on_body_entered(body) -> void:
	if body is MainCharacter:
		in_loot_range = true;

func _on_body_exited(body) -> void:
	if body is MainCharacter:
		in_loot_range = false;

func _on_item_collect_sound_finished():
	queue_free();
