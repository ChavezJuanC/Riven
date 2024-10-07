class_name CraftingPanelClass;
extends Panel

var crafted_potions :int;
@onready var inventory_button = $"../InventoryButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false;

func _on_button_button_down() -> void:
	if visible:
		visible = false;
	else:
		visible = true;

func _on_craft_button_pressed() -> void:
	crafted_potions = floor(GlobalGameHandler.shroom_count / 3.0)
	GlobalGameHandler.shroom_count -= (crafted_potions * 3)
	GlobalGameHandler.red_potion_count += crafted_potions
	inventory_button.populate_ui()

func _on_exit_pressed():
	visible = false;
