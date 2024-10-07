class_name LetterClass;
extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	
func _on_close_button_pressed():
	queue_free()
