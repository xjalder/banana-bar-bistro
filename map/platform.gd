class_name Platform extends Area2D

@onready var platform_body := $StaticBody2D

var num_arms_grappled : int = 0

func _ready() -> void:
	body_entered.connect(body_enter)
	SignalBus.grapple.connect(on_grapple)
	SignalBus.ungrapple.connect(on_ungrapple)
	SignalBus.falling_held.connect(_disable_collision)
	SignalBus.falling_released.connect(_enable_collision)

func body_enter(body : Node2D):
	var collision_dir = (body.global_position - platform_body.global_position).normalized()
	
	if collision_dir.y < 0:
		_enable_collision()
	else:
		_disable_collision()

func _enable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer |= platform_mask

func _disable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer &= ~platform_mask
		
func on_grapple() -> void:
	num_arms_grappled = min(2, num_arms_grappled + 1)
	if num_arms_grappled >= 1:
		_disable_collision()
	
func on_ungrapple() -> void:
	num_arms_grappled = max(0, num_arms_grappled - 1)
	if num_arms_grappled == 0:
		_enable_collision()
