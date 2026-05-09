class_name Platform extends Area2D

@onready var platform_body := $StaticBody2D

var grappling : bool
var crouching : bool
var num_arms_grappled : int = 0
var queued_collision : bool

func _ready() -> void:
	body_entered.connect(body_enter)
	body_exited.connect(body_exit)
	SignalBus.grapple.connect(on_grapple)
	
func body_enter(body : Node2D):
	if crouching:
		return
		
	var collision_dir = (body.global_position - platform_body.global_position).normalized()
	if collision_dir.y < 0:
		queued_collision = true
		if not grappling:
			_enable_collision()
	else:
		queued_collision = false
		_disable_collision()

func body_exit(_body : Node2D):
	_enable_collision()

func _enable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer |= platform_mask

func _disable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer &= ~platform_mask
		
func on_grapple() -> void:
	num_arms_grappled = min(2, num_arms_grappled + 1)
	if num_arms_grappled >= 1:
		grappling = true
		_disable_collision()
	
func on_ungrapple() -> void:
	num_arms_grappled = max(0, num_arms_grappled - 1)
	if num_arms_grappled == 0:
		grappling = false
		if queued_collision:
			_enable_collision()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crouch"):
		crouching = true
		_disable_collision()
	
	if event.is_action_released("crouch"):
		crouching = false
		if not grappling:
			_enable_collision()
