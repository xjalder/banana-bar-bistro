class_name Platform extends Area2D

@onready var platform_body := $StaticBody2D

var grappling : bool
var crouching : bool
var num_arms_grappled : int = 0
var player_inside: bool

func _ready() -> void:
	body_entered.connect(body_enter)
	body_exited.connect(body_exit)
	SignalBus.grapple.connect(on_grapple)
	SignalBus.ungrapple.connect(on_ungrapple)
	
func body_enter(body : Node2D):
	player_inside = true
	if crouching or grappling:
		return
		
	var collision_dir = (body.global_position - platform_body.global_position).normalized()
	if collision_dir.y < 0:
		_enable_collision()
	else:
		_disable_collision()

func body_exit(_body : Node2D):
	player_inside = false
	if not crouching and not grappling:
		_enable_collision()

func _try_enable() -> void:
	if not crouching and not grappling and not player_inside:
		_enable_collision()

func _enable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer |= platform_mask

func _disable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer &= ~platform_mask
		
func on_grapple() -> void:
	num_arms_grappled = min(2, num_arms_grappled + 1)
	grappling = true
	_disable_collision()
	
func on_ungrapple() -> void:
	num_arms_grappled = max(0, num_arms_grappled - 1)
	if num_arms_grappled == 0:
		grappling = false
		_enable_collision()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crouch"):
		crouching = true
		_disable_collision()
	
	if event.is_action_released("crouch"):
		crouching = false
		_try_enable()
