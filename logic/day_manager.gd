extends Node

var money: int
@export var curr_lv: Enums.Level

const main_scene : String = "res://logic/main.tscn"

var level_limit: Dictionary = {
	Enums.Level.LV1: 1, # one monkey order completed to finish day 
	Enums.Level.LV2: 2, #etc
	Enums.Level.LV3: 3,
	Enums.Level.LV4: 3,
	Enums.Level.LV5: 4
}

var customers_per_level : Array[int] = [1,2,4,5,7,9,10,15,20]
var happy_customer_count : int = 0

var monkeys_fed : int = 0

func _iterate_monkey_fed() ->void:
	monkeys_fed += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_lv = Enums.Level.LV1
	SignalBus.add_money.connect(_add_money)
	money = 0
func _next_level() -> void:
	if curr_lv == Enums.Level.LV5:
		curr_lv = Enums.Level.LV1
	else:
		curr_lv += 1
	GameManager.upgrades['capacity'] += 1

func _add_money(x :float) -> void:
	happy_customer_count += 1
	if (happy_customer_count == customers_per_level[curr_lv]):
		_reload_map()
	
func _reload_map() -> void:
	_next_level()
	await SceneManagerTscn.change_scene(get_tree().current_scene, main_scene)
	
