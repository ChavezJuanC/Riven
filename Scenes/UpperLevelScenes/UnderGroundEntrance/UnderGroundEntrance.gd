extends StaticBody2D

const ENTRANE_CONFIRMATION = preload("res://Scenes/UpperLevelScenes/UnderGroundEntrance/EntraneConfirmation.tscn")

@export var entrance_animator :AnimationPlayer
@export var text_indicator : Label
var in_entrance_perimeter :bool = false
var underground_access_requested :bool = false
var confirmation_instance :CanvasLayer = null
var confirmation_shown :bool = false  # Track if confirmation is currently shown

func _process(_delta) -> void:
	if confirmation_shown:
		check_confirm()

func _ready() -> void:
	entrance_animator.play("Idle", -1, 0.5, false)
	text_indicator.visible = false
	confirmation_instance = ENTRANE_CONFIRMATION.instantiate()

func show_confirmation(do_show :bool) -> void:
	if do_show:
		if confirmation_instance and not confirmation_shown:
			add_child(confirmation_instance)
			confirmation_shown = true
	else:
		if confirmation_instance and confirmation_shown:
			remove_child(confirmation_instance)
			confirmation_shown = false

func check_confirm() -> void:
	if Input.is_action_just_pressed("Accept"):
		print("Accepting Entry")
		get_tree().change_scene_to_file("res://MainGame/LowerLevel/LowerLevel.tscn")
		show_confirmation(false)

	elif Input.is_action_just_pressed("Decline"):
		show_confirmation(false)

func _on_entrance_perimeter_zone_body_entered(body):
	if body is MainCharacter:
		in_entrance_perimeter = true
		text_indicator.visible = true

func _on_entrance_perimeter_zone_body_exited(body):
	if body is MainCharacter:
		in_entrance_perimeter = false
		underground_access_requested = false
		text_indicator.visible = false
		show_confirmation(false)

func _on_main_character_looting() -> void:
	if in_entrance_perimeter:
		underground_access_requested = true
		if not confirmation_shown: 
			show_confirmation(true)


