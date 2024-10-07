class_name Letter
extends Node2D

@export var letter_label :Label;
@export var letter_canvas :CanvasLayer;
var in_loot_range: bool;

signal opening_letter;

func _ready() -> void:
	letter_label.visible = false;
	in_loot_range = false;

func _on_area_2d_body_entered(body):
	if body is MainCharacter:
		letter_label.visible = true;
		in_loot_range = true;

func _on_area_2d_body_exited(body):
	if body is MainCharacter:
		letter_label.visible = false;
		in_loot_range = false;
		
func _on_main_character_looting():
	if in_loot_range:
		opening_letter.emit()
		letter_canvas.visible = true;
		queue_free()
