class_name BananaHut extends Node2D

var monkey_scene : PackedScene = preload("/Users/ben/Desktop/banana-bar-bistro/map/banana hut/MonkeyCustomer.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
var MAX_MONKEYS : int = 5


var monkeys: Array[MonkeyCustomer] = []
signal deleted_monkey()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		
	
	
func _swawn_new_monkey() -> void:
	if (monkeys.size() > MAX_MONKEYS):
		return
	var parent_size : Vector2 = sprite_2d.texture.get_size()
	var x_pos : int =  -parent_size.x/2 + ((parent_size.x * monkeys.size())/MAX_MONKEYS)
	var y_pos : int = parent_size.y/4
	var monkey : MonkeyCustomer = _spawn_monkey_customer_at_position(Vector2(x_pos, y_pos))
	add_child(monkey)
	monkeys.append(monkey)
	

func _spawn_monkey_customer_at_position(position : Vector2) -> MonkeyCustomer:
	var monkey : MonkeyCustomer = monkey_scene.instantiate()
	monkey.position = Vector2(position)
	return monkey
	
func _delete_monkey() -> void:
	deleted_monkey.emit()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Spawn Monkey"):
		_swawn_new_monkey()
