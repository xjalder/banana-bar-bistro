class_name Droppable extends Node2D
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var sprite_2d: Sprite2D = $RigidBody2D/Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $RigidBody2D/CollisionShape2D


var type : Enums.Holdables

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _create_droppable(sprite : Sprite2D, type : Enums.Holdables) -> void:
	sprite_2d = sprite
	self.type = type

func _create_droppable_no_sprite(type : Enums.Holdables) -> void:
	if type == Enums.Holdables.BANANA:
		sprite_2d.texture = load("res://assets/banana hut/banana.png")
	elif type == Enums.Holdable.BANANA_BREAD:
		sprite_2d.texture = load("res://assets/banana hut/banana_bread.png")
	elif type == Enums.Holdable.BREAD:
		sprite_2d.texture = load("res://assets/banana hut/banana_bread.png")
	elif type == Enums.Holdable.BANANA_SMOOTHIE:
		sprite_2d.texture = load("res://assets/banana hut/smoothie.png")
	elif type == Enums.Holdable.BANANA_ICECREAM:
		sprite_2d.texture = load("res://assets/BananaSplit.webp")
	self.type = type
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
