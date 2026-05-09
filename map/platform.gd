class_name Platform extends Area2D

@onready var platform_body := $StaticBody2D

var grappling : bool
var crouching : bool
var left_arm_grappled : bool
var right_arm_grappled : bool
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
	if left_arm_grappled or right_arm_grappled:
		return
		
	var platform_mask = 1 << 4
	platform_body.collision_layer |= platform_mask

func _disable_collision() -> void:
	var platform_mask = 1 << 4
	platform_body.collision_layer &= ~platform_mask
		
func on_grapple(is_left : bool) -> void:
	if is_left:
		left_arm_grappled = true
	else:
		right_arm_grappled = true
	grappling = true
	_disable_collision()
	
func on_ungrapple(is_left : bool) -> void:
	if is_left:
		left_arm_grappled = false
	else:
		right_arm_grappled = false
	if not left_arm_grappled and not right_arm_grappled:
		grappling = false
		_enable_collision()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crouch"):
		crouching = true
		_disable_collision()
	
	if event.is_action_released("crouch"):
		crouching = false
		_try_enable()
