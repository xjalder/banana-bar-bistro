extends Node2D

@onready var left_eye: Sprite2D = $FaceSprite/LeftEye
@onready var right_eye: Sprite2D = $FaceSprite/RightEye
@onready var face_sprite: Sprite2D = $FaceSprite
@onready var collector: Collector = $Collector

var droppable_scene: PackedScene = preload("res://logic/Droppable.tscn")
var types: Array[Enums.Holdables] = [0, 0]
var holdable_textures: Dictionary[Enums.Holdables, Texture] = {
	Enums.Holdables.BANANA: preload("res://assets/banana hut/banana.png"),
	Enums.Holdables.BREAD: preload("res://assets/banana hut/Bread.png"),
	Enums.Holdables.MILK: preload("res://assets/banana hut/BananaSmoothieSlim.png"),
	Enums.Holdables.ICE: preload("res://assets/banana hut/banana.png"),
	Enums.Holdables.BANANA_SMOOTHIE: preload("res://assets/banana hut/BananaSmoothieSlim.png"),
	Enums.Holdables.BANANA_BREAD: preload("res://assets/banana hut/Bread.png"),
	Enums.Holdables.BANANA_ICECREAM: preload("res://assets/banana hut/BananaSmoothieSlim.png"),
}

# Shake state
enum ShakeState { IDLE, ACTIVE, SPAWNING }
var shake_state: ShakeState = ShakeState.IDLE
var shake_time: float = 0.0
var face_origin: Vector2

# Idle shake (slow, lazy tiki sway)
var idle_shake_speed: float = 0.5
var idle_shake_amount: float = 15.0

# Active shake (fast, frantic)
var active_shake_speed: float = 5.0
var active_shake_amount: float = 8.0

func _ready() -> void:
	face_origin = face_sprite.position
	collector.collect_fruit.connect(_add_holdable_to_face)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_monkey"):
		_add_holdable_to_face(Enums.Holdables.BANANA)

	match shake_state:
		ShakeState.IDLE:
			shake_time += delta
			face_sprite.position.x = face_origin.x + sin(shake_time * idle_shake_speed * TAU) * idle_shake_amount
			face_sprite.position.y = face_origin.y + abs(sin(shake_time * idle_shake_speed * TAU)) * (idle_shake_amount * 0.3)
		ShakeState.ACTIVE:
			shake_time += delta
			face_sprite.position.x = face_origin.x + sin(shake_time * active_shake_speed * TAU) * active_shake_amount
			face_sprite.position.y = face_origin.y + abs(sin(shake_time * active_shake_speed * TAU)) * (active_shake_amount * 0.3)
		ShakeState.SPAWNING:
			# Tween handles movement, just lerp back to rest
			face_sprite.position = face_sprite.position.lerp(face_origin, 0.25)

func _add_holdable_to_face(holding: Enums.Holdables) -> void:
	if not left_eye.texture:
		left_eye.texture = holdable_textures.get(holding)
		_apply_eye_scale(left_eye)
		types[0] = holding
		_set_active_shake()
	elif not right_eye.texture:
		right_eye.texture = holdable_textures.get(holding)
		_apply_eye_scale(right_eye)
		types[1] = holding
		_finish_and_spawn()

func _apply_eye_scale(eye: Sprite2D) -> void:
	var eye_size: Vector2 = eye.get_rect().size
	var face_size: Vector2 = face_sprite.get_rect().size
	eye.scale = Vector2(face_size.x / (5.0 * eye_size.x), face_size.y / (5.0 * eye_size.y))

func _set_active_shake() -> void:
	shake_state = ShakeState.ACTIVE
	shake_time = 0.0

func _finish_and_spawn() -> void:
	shake_state = ShakeState.SPAWNING
	shake_time = 0.0

	await get_tree().create_timer(0.3).timeout

	var tween := create_tween()
	tween.tween_property(face_sprite, "scale", Vector2(1.2, 0.9), 0.15)
	tween.tween_property(face_sprite, "scale", Vector2(0.9, 1.2), 0.15)
	tween.tween_property(face_sprite, "scale", Vector2(1.0, 1.0), 0.12)

	await get_tree().create_timer(0.08).timeout
	_make_product()

	left_eye.texture = null
	right_eye.texture = null
	types = [0, 0]

	await get_tree().create_timer(0.4).timeout

	# Return to slow idle shake once cooldown is done
	shake_state = ShakeState.IDLE
	shake_time = 0.0

func _make_product() -> void:
	if types == [Enums.Holdables.BANANA, Enums.Holdables.BANANA]:
		_spawn_product(Enums.Holdables.BANANA)
	elif types == [Enums.Holdables.BANANA, Enums.Holdables.BREAD] or types == [Enums.Holdables.BREAD, Enums.Holdables.BANANA]:
		_spawn_product(Enums.Holdables.BANANA_BREAD)
	elif types == [Enums.Holdables.BANANA, Enums.Holdables.MILK] or types == [Enums.Holdables.MILK, Enums.Holdables.BANANA]:
		_spawn_product(Enums.Holdables.BANANA_SMOOTHIE)
	elif types == [Enums.Holdables.BANANA_SMOOTHIE, Enums.Holdables.ICE] or types == [Enums.Holdables.ICE, Enums.Holdables.BANANA_SMOOTHIE]:
		_spawn_product(Enums.Holdables.BANANA_ICECREAM)
	else:
		_spawn_product(types.pick_random())

func _spawn_product(product: Enums.Holdables) -> void:
	var dropped: Droppable = droppable_scene.instantiate()
	PlayerManager.dropped_items.add_child(dropped)
	dropped._create_droppable_no_sprite(product, self.global_position + Vector2(0, -20))
