extends Node

#resource manager change name
var money: int

var is_paused : bool = false

var items = {'capacity': 100, 'time_to_new_customer':50, 'money_multiplier':120, "time_to_unhappy":150}
var increases = {'capacity': 2, 'time_to_new_customer': 5, 'money_multiplier': 3, "time_to_unhappy": 90}

var upgrades = {
	'capacity': 3,
	'time_to_new_customer': 3,
	'money_multiplier': 4,
	'time_to_unhappy': 10}

signal show_cash(money : int)

signal buy_order(_buy_item)

func _add_money(income : int)->void:
	money += income
	show_cash.emit(money)

func buy_item(item: String)->bool:
	if items.get(item) <= money:
		print("BOUGHT! ", money)
		money -= items.get(item)
		for i in upgrades.keys(): #change item bought
			if i == item:
				upgrades[i] += increases.get(item)
		return true
	print("FAILED!", money)
	return false


#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 500


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		is_paused = true
