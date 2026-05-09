class_name MonkeyCustomer extends Node2D

#currenly 0, 1, 2 should change later to have what each is make of maybe??
var order_sprite : PackedScene = preload("res://map/banana hut/food orders/order_sprite.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
var order : Enums.Order
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
var progress_bar_value : float = 0
var upgrades : Dictionary = GameManager.upgrades
var time_to_unhappy : int = upgrades["time_to_unhappy"];



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var values := Enums.Order.values()
	
	var x: int = randi_range(0, values.size() - 1)
	if (values[x] == Enums.Order.BANANA):
		_spawn_sprite(order_sprite, "res://assets/banana hut/banana.png")
		order = Enums.Order.BANANA
	elif (values[x] == Enums.Order.BANANA_BREAD):
		_spawn_sprite(order_sprite, "res://assets/banana hut/banana_bread.png")
		order = Enums.Order.BANANA_BREAD
	elif (values[x] == Enums.Order.BANANA_SMOOTHIE):
		_spawn_sprite(order_sprite, "res://assets/banana hut/smoothie.png")
		order = Enums.Order.BANANA_SMOOTHIE
		

func _spawn_sprite(scene : PackedScene, path :String) -> void:
	var order := scene.instantiate()
	var parent_size : Vector2 = sprite_2d.get_rect().size
	order.position = Vector2(0,0)
	order.get_node("Sprite2D").texture = load(path)
	var order_size : Vector2 = order.get_node("Sprite2D").get_rect().size
	#print(order_size,parent_size)
	order.get_node("Sprite2D").scale= Vector2(parent_size.x / (2 *order_size.x), parent_size.y/ (2 * order_size.y))
	add_child(order)
	
	

	
	
# Called every frame. 'delta' is the elapsed timprogress_bar_valuee since the previous frame.
func _process(delta: float) -> void:
	progress_bar_value += float(100/time_to_unhappy) * delta
	texture_progress_bar.value = floor(progress_bar_value)
	if (progress_bar_value >= 100):
		SignalBus.unhappy_customer.emit(self)
		
