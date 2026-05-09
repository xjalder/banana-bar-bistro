class_name Spawner extends Node2D

@export var growable : Enums.Growables
@export var branch_sprite : Sprite2D
@export var capacity : int
@export var regrow_speed : int

var regrow_timer : Timer
var texture : Texture
var num_fruits : int
var bound_blocks : Array[Rect2]
var current_block: int = randi_range(0,2)

var growable_textures : Dictionary[Enums.Growables, Texture] = {
	Enums.Growables.Banana: preload("res://assets/banana hut/banana.png"),
	Enums.Growables.Bread: preload("res://assets/banana hut/banana_bread.png"),
	Enums.Growables.Milk: preload("res://assets/banana hut/smoothie.png"),
	Enums.Growables.Ice: preload("res://assets/banana hut/banana.png")
}

func _ready() -> void:
	if growable == Enums.Growables.None:
		return
	
	texture = growable_textures.get(growable)
	
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

func _regrow() -> void:
	var box: Rect2 = bound_blocks[current_block]
	current_block = (current_block + 1) % bound_blocks.size()
	
	var fruit := Sprite2D.new()
	fruit.texture = texture
	fruit.scale *= 0.05
	fruit.position = Vector2(
		randf_range(box.position.x, box.position.x + box.size.x),
		randf_range(box.position.y, box.position.y + box.size.y)
	)
	add_child(fruit)
	
	num_fruits += 1
	if num_fruits >= capacity:
		regrow_timer.stop()
	
