extends Node2D

@export var walkspeed : float

@onready var body : PlayerBody = $Body

var grappled : bool = false
var left_arm_grappled : bool
var right_arm_grappled : bool

var walk_left_held : bool
var walk_right_held : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.grapple.connect(on_grapple)
	SignalBus.ungrapple.connect(on_ungrapple)

func _physics_process(delta: float) -> void:
	if body.get_contact_count() < 1 or (grappled or (walk_left_held and walk_right_held)):
		return
	
	if walk_left_held:
		body.global_position = lerp(body.global_position, body.global_position + Vector2(-walkspeed, 0), 0.3)
	elif walk_right_held:
		body.global_position = lerp(body.global_position, body.global_position + Vector2(walkspeed, 0), 0.3)

func on_grapple(is_left : bool) -> void:
	if is_left:
		left_arm_grappled = true
	else:
		right_arm_grappled = true
	grappled = true
	body.mass = 5
	
func on_ungrapple(is_left : bool) -> void:
	if is_left:
		left_arm_grappled = false
	else:
		right_arm_grappled = false
	if not left_arm_grappled and not right_arm_grappled:
		grappled = false
		body.mass = 500
#
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("walk_left"):
		walk_left_held = true
	elif event.is_action_pressed("walk_right"):
		walk_right_held = true
		
	if event.is_action_released("walk_left"):
		walk_left_held = false
	elif event.is_action_released("walk_right"):
		walk_right_held = false
