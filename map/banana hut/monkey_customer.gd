class_name MonkeyCustomer extends Node2D

# currenly 0, 1, 2 should change later to have what each is make of maybe??
enum Order {BANANA, BANANA_BREAD, BANANA_SMOOTHIE}
var order_sprite : PackedScene = preload("/Users/ben/Desktop/banana-bar-bistro/map/banana hut/food orders/order_sprite.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
var order : Order

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var values := Order.values()
	
	var x: int = randi_range(0, values.size() - 1)
	print(values[x])
	if (values[x] == Order.BANANA):
		_spawn_sprite(order_sprite, "/Users/ben/Desktop/banana-bar-bistro/assets/banana hut/banana_PNG835.png")
	elif (values[x] == Order.BANANA_BREAD):
		_spawn_sprite(order_sprite, "/Users/ben/Desktop/banana-bar-bistro/assets/banana hut/pngtree-delicious-homemade-banana-bread-loaf-sliced-on-wooden-board-with-fresh-png-image_20728460.png")
	elif (values[x] == Order.BANANA_SMOOTHIE):
		_spawn_sprite(order_sprite, "/Users/ben/Desktop/banana-bar-bistro/assets/banana hut/smoothie.png")
		

func _spawn_sprite(scene : PackedScene, path :String) -> void:
	var order := scene.instantiate()
	#var parent_size : Vector2 = sprite_2d.texture.get_size()
	order.position = Vector2(0,0)
	order.get_node("Sprite2D").texture = load(path)
	add_child(order)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
