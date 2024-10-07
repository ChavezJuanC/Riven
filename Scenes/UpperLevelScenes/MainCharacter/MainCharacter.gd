class_name MainCharacter
extends CharacterBody2D

@export var walking_speed : float
@export var player_animator: AnimationPlayer
enum State {IDLE, WALK}
var state :State
var state_complete: bool
var last_facing_dir: String
var is_looting: bool

signal Looting

func _ready() -> void :
	state = State.IDLE
	state_complete = true
	last_facing_dir = "south"

func _process(_delta) -> void :
	check_looting()
	if state_complete:
		select_state()
	update_state()

func _physics_process(_delta) -> void :
	handle_movement()

func handle_movement() -> void : 
	var direction :Vector2 = set_directions()
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	velocity = direction * walking_speed
	move_and_slide()

func set_directions() -> Vector2:
	var side_direction : float = Input.get_axis("ui_left", "ui_right") 
	var updown_direction : float = Input.get_axis("ui_up", "ui_down")
	return Vector2(side_direction, updown_direction)

#create select_state(conditional) 
func select_state() -> void :
	state_complete = false
	if velocity.x != 0 or velocity.y != 0:
		state = State.WALK
	if velocity.x == 0 and velocity.y == 0:
		state = State.IDLE
	
	update_state()

func update_state() -> void :
	match state:
		State.IDLE:
			update_idle()
		State.WALK:
			update_walk()

func update_idle() -> void : 
	if velocity.x != 0 or velocity.y != 0:
		state_complete = true
	else:
		player_animator.play("idle_" + last_facing_dir)

func update_walk() -> void : 
	check_facing_dir()
	if velocity.x == 0 and velocity.y == 0:
		state_complete = true
	else:
		player_animator.play("walk_" + last_facing_dir)

func check_facing_dir() -> void:
	# Check for the correct animation direction based on Godot's coordinate system
	if velocity.y < 0 and velocity.x == 0:
		last_facing_dir = "north"       # Moving up
	elif velocity.y < 0 and velocity.x > 0:
		last_facing_dir = "north_east"  # Moving up-right
	elif (velocity.y > 0 and velocity.x > 0) or (velocity.y == 0 and velocity.x > 0):
		last_facing_dir = "south_east"  # Moving down-right or right
	elif velocity.y > 0 and velocity.x == 0:
		last_facing_dir = "south"       # Moving down
	elif (velocity.y > 0 and velocity.x < 0) or (velocity.y == 0 and velocity.x < 0):
		last_facing_dir = "south_west"  # Moving down-left or left
	elif velocity.y < 0 and velocity.x < 0:
		last_facing_dir = "north_west"  # Moving up-left

func check_looting() -> void :
	is_looting = Input.is_action_just_pressed("Loot")
	if is_looting:
		Looting.emit()
