class_name Droppable extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: CollectArea = $Area2D
@onready var pickupcol: CollisionShape2D = $Area2D/pickupcol

var type: Enums.Holdables
var flash_timer: Timer
var despawn_timer: Timer
var flash_tween: Tween
var pickupable : bool = true

const LIFETIME := 5.0
const FLASH_DURATION := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1
	area_2d.fruit_taken.connect(func() -> void: _cleanup())

	despawn_timer = Timer.new()
	despawn_timer.wait_time = LIFETIME - FLASH_DURATION
	despawn_timer.one_shot = true
	despawn_timer.timeout.connect(_start_flashing)
	add_child(despawn_timer)
	despawn_timer.start()

	flash_timer = Timer.new()
	flash_timer.wait_time = LIFETIME
	flash_timer.one_shot = true
	flash_timer.timeout.connect(_cleanup)
	add_child(flash_timer)
	flash_timer.start()

func _start_flashing() -> void:
	var red := Color(1, 0.15, 0.15)
	var white := Color(1, 1, 1)
	flash_tween = create_tween().set_loops()
	flash_tween.tween_property(sprite_2d, "modulate", red, 0.1)
	flash_tween.tween_property(sprite_2d, "modulate", white, 0.1)
	
func _cleanup() -> void:
	if flash_tween:
		flash_tween.kill()
	queue_free()

func _create_droppable(sprite : Sprite2D, type : Enums.Holdables) -> void:
	sprite_2d = sprite
	self.type = type
	area_2d.holdable = type
	area_2d.texture = sprite.texture

func _create_droppable_no_sprite(type : Enums.Holdables, position :Vector2) -> void:
	if type == Enums.Holdables.BANANA:
		sprite_2d.texture = load("res://assets/banana.png")
		sprite_2d.scale *= 2
	elif type == Enums.Holdables.BANANA_BREAD:
		sprite_2d.texture = load("res://assets/banana hut/banana_bread.png")
	elif type == Enums.Holdables.BREAD:
		sprite_2d.texture = load("res://assets/banana hut/banana_bread.png")
	elif type == Enums.Holdables.BANANA_SMOOTHIE:
		sprite_2d.texture = load("res://assets/banana hut/smoothie.png")
	elif type == Enums.Holdables.BANANA_ICECREAM:
		sprite_2d.texture = load("res://assets/BananaSplit.webp")
	area_2d.holdable = type
	area_2d.texture = sprite_2d.texture
	self.global_position = position
	self.type = type
