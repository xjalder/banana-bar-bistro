extends Node2D

@export var walkspeed : float

@onready var body : PlayerBody = $Body

var grappled : bool = false
var num_arms_grappled : int = 0

var walk_left_held : bool
var walk_right_held : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.grapple.connect(on_grapple)
	SignalBus.ungrapple.connect(on_ungrapple)

func _physics_process(delta: float) -> void:
	if grappled or (walk_left_held and walk_right_held):
		return
	
	if walk_left_held:
		body.global_position = lerp(body.global_position, body.global_position + Vector2(-walkspeed, 0), 0.3)
	elif walk_right_held:
		body.global_position = lerp(body.global_position, body.global_position + Vector2(walkspeed, 0), 0.3)

func on_grapple() -> void:
	num_arms_grappled = min(2, num_arms_grappled + 1)
	if num_arms_grappled >= 1:
		grappled = true
		body.mass = 5
	
func on_ungrapple() -> void:
	num_arms_grappled = max(0, num_arms_grappled - 1)
	if num_arms_grappled == 0:
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
