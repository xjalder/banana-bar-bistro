extends Node

#resource manager change name
var money: int

var is_paused : bool = false

var items = {Enums.Items.DECOS : 100, Enums.Items.CHAIRS:50, Enums.Items.MUSIC:120}
var increases = {Enums.Items.DECOS : 2, Enums.Items.CHAIRS: 5, Enums.Items.MUSIC: 3}

var upgrades = {
	Enums.Items.DECOS: 3,
	Enums.Items.MUSIC: 3,
	Enums.Items.CHAIRS : 4}

signal show_cash(money : int)

signal buy_order(_buy_item)

func _add_money(income : int)->void:
	money += income
	show_cash.emit(money)

func buy_item(item: Enums.Items)->bool:
	if items.get(item) <= money:
		print("BOUGHT! ", money)
		money -= items.get(item)
		for i in upgrades.keys(): #change item bought
			if i == item:
				upgrades[i] += increases.get(item)
		return true
	print("FAILED!", money)
	return false
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 500
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		is_paused = true
		
	
