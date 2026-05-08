class_name MonkeyCustomer extends Node2D

# currenly 0, 1, 2 should change later to have what each is make of maybe??
enum Order {BANANA, BANANA_BREAD, BANANA_SMOOTHIE}
var banana_order : PackedScene = preload("/Users/ben/Desktop/banana-bar-bistro/map/banana hut/food orders/banana_order.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
var order : Order

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var values := Order.values()
	
	var x: int = randi_range(0, values.size() - 1)
	print(values[x])
	if (values[x] == Order.BANANA):
		_spawn_sprite(banana_order)
		

func _spawn_sprite(scene : PackedScene) -> void:
	var sprite := scene.instantiate()
	var parent_size : Vector2 = sprite_2d.texture.get_size()
	sprite.position = Vector2(0,0)
	add_child(sprite)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
