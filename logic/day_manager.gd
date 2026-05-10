extends Node

var money: int
@export var curr_lv: Enums.Level

const main_scene : String = "res://logic/main.tscn"
const buy_scene : String = "res://ui/buy_screen.tscn"
const end_scene : String = "res://ui/game_over.tscn"


var customers_per_level : Array[int] = [2,2,3,5,7,9,11,13,15,17,20,25,30,30,30]
var happy_customer_count : int = 0

var max_capacity_of_branches : Array[int] = [1,1,2,2,2,3,3,3,3,3,3,3]
var monkeys_fed : int = 0

func _iterate_monkey_fed() ->void:
	monkeys_fed += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_lv = Enums.Level.LV1
	SignalBus.add_money.connect(_add_money)
	SignalBus.unhappy_customer.connect(_end_game)
	money = 0
	
func _next_level() -> void:
	curr_lv += 1
	GameManager.upgrades['capacity'] += 1

func _add_money(x :float) -> void:
	happy_customer_count += 1
	if (happy_customer_count == customers_per_level[curr_lv]):
		_next_level()
		SignalBus.play_win_sound.emit()
		await SceneManagerTscn.change_scene(get_tree().current_scene, main_scene)
		happy_customer_count = 0

func _end_game(_customer : MonkeyCustomer) -> void:
	await SceneManagerTscn.change_scene(get_tree().current_scene, end_scene)
