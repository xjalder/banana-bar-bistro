class_name BananaHut extends Node2D

var monkey_scene : PackedScene = preload("res://map/banana hut/MonkeyCustomer.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
var current_monkey_count : int = 0
var upgrades : Dictionary= GameManager.upgrades 
var MAX_MONKEYS : int = min(DayManager.customers_per_level.get(DayManager.curr_lv), 5)
@onready var timer_to_new_customer: Timer = $Timer


var monkeys: Array[MonkeyCustomer] = []

signal deleted_monkey


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monkeys.resize(MAX_MONKEYS)
	SignalBus.unhappy_customer.connect(_unhappy_monkey_leave)
	timer_to_new_customer.wait_time = upgrades["time_to_new_customer"]
	timer_to_new_customer.one_shot = false
	timer_to_new_customer.start()
	_create_stool()
	
	

func _create_stool() -> void:
	var parent_size : Vector2 = sprite_2d.texture.get_size()
	for i in range(MAX_MONKEYS):
		var x_pos: float = -parent_size.x / 2.0 + (parent_size.x * i) / (MAX_MONKEYS - 1)
		var y_pos : int = parent_size.y/2 - parent_size.y/30
		var new_sprite = Sprite2D.new()
		new_sprite.texture = load("res://assets/banana hut/WoodenStoolV2.webp")
		new_sprite.position = Vector2(x_pos, y_pos)
		add_child(new_sprite)
		
		
	
	

func _on_timer_timeout():
	_spawn_new_monkey()
		
func _unhappy_monkey_leave(unhappy_monkey : MonkeyCustomer) -> void:
	for i in range(len(monkeys)):
		
		if (monkeys.get(i) == unhappy_monkey):
			_delete_monkey_at_index(i)
	
func _spawn_new_monkey() -> void:
	if (current_monkey_count >= MAX_MONKEYS):
		return
		
	var null_count : int = 0;
	var index_for_monkey : int = randi_range(1, MAX_MONKEYS - current_monkey_count) 
	for i in range(len(monkeys)):
		if monkeys.get(i) == null:
			null_count += 1
		else:
			continue
			
		if null_count == index_for_monkey:
			var parent_size : Vector2 = sprite_2d.texture.get_size()
			var x_pos: float = -parent_size.x / 2.0 + (parent_size.x * i) / (MAX_MONKEYS - 1)
			var y_pos : int = parent_size.y/4 + parent_size.y/30
			var monkey : MonkeyCustomer = _spawn_monkey_customer_at_position(Vector2(x_pos, y_pos))
			add_child(monkey)
			monkeys[i] = monkey
			current_monkey_count += 1
			return
		

	

func _spawn_monkey_customer_at_position(position : Vector2) -> MonkeyCustomer:
	var monkey : MonkeyCustomer = monkey_scene.instantiate()
	var skin : int = randi_range(1, 4)
	monkey.get_node("Sprite2D").texture = load("res://assets/banana hut/MonkeyCustomer%s.webp" % skin)
	monkey.position = Vector2(position)
	return monkey
	
func _deleted_monkey() -> void:
	deleted_monkey.emit()
	
func _delete_monkey_at_index(index :int) -> void:
	monkeys.get(index).queue_free()
	_deleted_monkey()
	current_monkey_count -= 1
		
func _remove_monkey_with_order(order : Enums.Holdables) -> bool:
	for i in range(len(monkeys)):
		if monkeys[i] != null and monkeys[i].order == order:
			_delete_monkey_at_index(i)
			SignalBus.happy_customer.emit(monkeys[i])
			SignalBus.add_money.emit(Enums.OrderCost[order] * upgrades["money_multiplier"])
			return true
	return false
