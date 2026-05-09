class_name Spawner extends Node2D

@export var holdable : Enums.Holdables
@export var branch_sprite : Sprite2D
@export var capacity : int
@export var regrow_speed : int

@onready var collect : CollectArea = $CollectArea

var regrow_timer : Timer
var texture : Texture
var num_fruits : int
var bound_blocks : Array[Rect2]
var current_block: int = randi_range(0,2)

var holdable_textures : Dictionary[Enums.Holdables, Texture] = {
	Enums.Holdables.BANANA: preload("res://assets/banana hut/banana.png"),
	Enums.Holdables.BREAD: preload("res://assets/banana hut/Bread.png"),
	Enums.Holdables.MILK: preload("res://assets/banana hut/BananaSmoothieSlim.png"),
	Enums.Holdables.ICE: preload("res://assets/banana hut/banana.png")
}

func _ready() -> void:
	if holdable == Enums.Holdables.NONE:
		return
	
	texture = holdable_textures.get(holdable)
	collect.holdable = holdable
	collect.texture = texture
	
	var full := branch_sprite.get_rect()
	var margin := 30.0
	var padded := Rect2(
		full.position.x + margin,
		full.position.y + margin,
		full.size.x - margin * 2,
		full.size.y - margin * 2
	)

	var section_w := padded.size.x / 3.0
	for i in range(3):
		var block := Rect2(
			padded.position.x + section_w * i,  # offset each third
			padded.position.y, 
			section_w,
			padded.size.y * 0.5
		)
		bound_blocks.append(block)
	
	regrow_timer = Timer.new()
	regrow_timer.wait_time = regrow_speed
	regrow_timer.autostart = false
	regrow_timer.one_shot = false
	regrow_timer.timeout.connect(_regrow)
	add_child(regrow_timer)
	
	regrow_timer.start()
	collect.fruit_taken.connect(remove_fruit)

func _regrow() -> void:
	var box: Rect2 = bound_blocks[current_block]
	current_block = (current_block + 1) % bound_blocks.size()
	
	var fruit := Sprite2D.new()
	fruit.texture = texture
	fruit.scale *= 1
	fruit.position = Vector2(
		randf_range(box.position.x, box.position.x + box.size.x),
		randf_range(box.position.y, box.position.y + box.size.y)
	)
	add_child(fruit)
	
	num_fruits += 1
	if num_fruits >= capacity:
		regrow_timer.stop()

func remove_fruit() -> void:
	if num_fruits == 0:
		return
		
	for child in get_children():
		if child is Sprite2D:
			child.queue_free()
			num_fruits -= 1
			return
