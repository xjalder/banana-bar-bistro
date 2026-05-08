class_name MonkeyCustomer extends Node2D

# currenly 0, 1, 2 should change later to have what each is make of maybe??
enum Order {BANANA, BANANA_BREAD, BANANA_SMOOTHIE}
var order_sprite : PackedScene = preload("res://map/banana hut/food orders/order_sprite.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
var order : Order
var order_type : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var values := Order.values()
	
	var x: int = randi_range(0, values.size() - 1)
	print(values[x])
	if (values[x] == Order.BANANA):
		_spawn_sprite(order_sprite, "res://assets/banana hut/banana.png")
		order_type = "banana"
	elif (values[x] == Order.BANANA_BREAD):
		_spawn_sprite(order_sprite, "res://assets/banana hut/banana_bread.png")
		order_type = "banana_bread"
	elif (values[x] == Order.BANANA_SMOOTHIE):
		_spawn_sprite(order_sprite, "res://assets/banana hut/smoothie.png")
		order_type = "smoothie"
		

func _spawn_sprite(scene : PackedScene, path :String) -> void:
	var order := scene.instantiate()
	var parent_size : Vector2 = sprite_2d.get_rect().size
	order.position = Vector2(0,0)
	order.get_node("Sprite2D").texture = load(path)
	var order_size : Vector2 = order.get_node("Sprite2D").get_rect().size
	#print(order_size,parent_size)
	order.get_node("Sprite2D").scale= Vector2(parent_size.x / (2 *order_size.x), parent_size.y/ (2 * order_size.y))
	add_child(order)
	
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
