extends Node

var orders : Array[BananaOrder]

signal fulfil_order(order : BananaOrder)

func _ready() -> void:
	fulfil_order.connect(handle_order)

func handle_order(order : BananaOrder) -> void:
	pass
