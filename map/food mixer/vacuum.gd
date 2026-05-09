class_name FruitVacuum extends Area2D

const PULL_POINT := Vector2(0, -100)
const PULL_STRENGTH := 300.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body is RigidBody2D:
		return
	body.gravity_scale = 0
	body.linear_velocity = Vector2.ZERO
	body.pickupable = false
	set_meta("pulling_" + str(body.get_instance_id()), body)

func _physics_process(delta: float) -> void:
	for key in get_meta_list():
		if not key.begins_with("pulling_"):
			continue
		if !is_instance_valid(get_meta(key)):
			continue
		var body: RigidBody2D = get_meta(key)
		if not is_instance_valid(body):
			remove_meta(key)
			continue
		if not overlaps_body(body):
			body.gravity_scale = 1.0
			body.pickupable = true
			remove_meta(key)
			continue

		var direction := (to_global(PULL_POINT) - body.global_position).normalized()
		var distance := body.global_position.distance_to(to_global(PULL_POINT))
		# Strengthen pull as it gets closer
		var force : Vector2 = direction * PULL_STRENGTH * (1.0 / max(distance, 1.0)) * 1000.0
		body.apply_central_force(force)
