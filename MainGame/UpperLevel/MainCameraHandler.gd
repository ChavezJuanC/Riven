extends Camera2D

@export var player_body :CharacterBody2D

func _ready() -> void:
	pass

func _process(_delta) -> void:
	set_cam_position()

func set_cam_position() -> void:
	position = player_body.position
