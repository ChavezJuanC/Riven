class_name GameHandler
extends Node

var green_potion_count :int = 0;
var red_potion_count :int = 0;
var shroom_count :int = 0;
var spear_count :int = 0;
var ak_count :int = 0;

##track shroom 
func shroom_collected() -> void:
	shroom_count += 1

##calling it add potion wiht the the goal of modularity... use it for crafting too
func add_potion(potionType :String) -> void:
	if potionType == "speed":
		green_potion_count += 1;
	elif potionType == "health":
		red_potion_count += 1;
		
func Weapon_Collected(weapon_type : String) -> void:
	match weapon_type:
		"Ak-47":
			ak_count = 1
		"Spear":
			spear_count = 1

