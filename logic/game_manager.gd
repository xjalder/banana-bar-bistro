extends Node

var money: int

signal show_cash(money : int)



func _add_money(income : int)->void:
	money += income
	show_cash.emit(money)

func _buy_item(money : int, )->void:
	money


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 0
	#BananaHut.connect(_add_money)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
