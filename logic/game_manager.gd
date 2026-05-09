extends Node

#resource manager change name
var money: int

var is_paused : bool = false

var items = {"SEATS":100, "MAGIC":50, "DECO":120}

var upgrades = {
	"capacity": 3,
	"time_to_unhappy": 5,
	"time_to_new_customer" : 3}

var owned_items = []

signal show_cash(money : int)



func _add_money(income : int)->void:
	money += income
	show_cash.emit(money)

func _buy_item(money : int, item: String)->void:
	if items.get(item) <= money:
		money -= items.get(item)
		owned_items.append(item)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 0
	#BananaHut.connect(_add_money)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		is_paused = true
		
	
