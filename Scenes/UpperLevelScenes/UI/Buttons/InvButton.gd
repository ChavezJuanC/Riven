class_name InventoryButton;
extends Button

@export var InvUI :Panel
@export var red_potion_label :Label
@export var green_potion_label :Label
@export var shrooms_label :Label
@export var SpearLabel :Label
@export var AkLabel :Label
@export var CraftingPanel :Panel;

var inv_opened :bool

func _ready() -> void:
	InvUI.visible = false
	initialize_inventory()

func _on_button_down() -> void:
	if inv_opened:
		InvUI.visible = false
		if CraftingPanel.visible:
			CraftingPanel.visible = false;
	else:
		populate_ui()
		InvUI.visible = true
		
	inv_opened = !inv_opened
	
func initialize_inventory() -> void:
	red_potion_label.text = "x0"
	green_potion_label.text = "x0" 
	shrooms_label.text = "x0"
	AkLabel.text = "x0"
	SpearLabel.text = "x0"

func populate_ui() -> void:
	red_potion_label.text = "x" + str(GlobalGameHandler.red_potion_count)
	green_potion_label.text = "x" + str(GlobalGameHandler.green_potion_count)
	shrooms_label.text = "x" + str(GlobalGameHandler.shroom_count)
	SpearLabel.text = "x" + str(GlobalGameHandler.spear_count)
	AkLabel.text = "x" + str(GlobalGameHandler.ak_count)




