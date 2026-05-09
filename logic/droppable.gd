class_name Droppable extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: CollectArea = $Area2D
@onready var pickupcol: CollisionShape2D = $Area2D/pickupcol


var type : Enums.Holdables

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1
	area_2d.fruit_taken.connect(func ()-> void: queue_free())

func _create_droppable(sprite : Sprite2D, type : Enums.Holdables) -> void:
	sprite_2d = sprite
	self.type = type
	area_2d.holdable = type
	pickupcol.shape 
	area_2d.texture = sprite.texture

func _create_droppable_no_sprite(type : Enums.Holdables, position :Vector2) -> void:
	if type == Enums.Holdables.BANANA:
		sprite_2d.texture = load("res://assets/banana.png")
		sprite_2d.scale *= 2
		
		area_2d.holdable = type
		area_2d.texture = sprite_2d.texture
	elif type == Enums.Holdable.BANANA_BREAD:
		sprite_2d.texture = load("res://assets/banana hut/banana_bread.png")
	elif type == Enums.Holdable.BREAD:
		sprite_2d.texture = load("res://assets/banana hut/banana_bread.png")
	elif type == Enums.Holdable.BANANA_SMOOTHIE:
		sprite_2d.texture = load("res://assets/banana hut/smoothie.png")
	elif type == Enums.Holdable.BANANA_ICECREAM:
		sprite_2d.texture = load("res://assets/BananaSplit.webp")
	self.position = position
	self.type = type
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
