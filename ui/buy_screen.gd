extends Control

signal shop_done

var active : bool = false

@onready var icons = {
'capacity': preload("res://assets/banana hut/banana.png"),
'time_to_unhappy': preload("res://assets/banana hut/banana.png"),
'time_to_new_customer': preload("res://assets/banana hut/banana.png"),
'money_multiplier': preload("res://assets/banana hut/banana.png"),
}

@onready var texts = {
	'capacity': "capacity increase",
	'time_to_unhappy': "wait time increase",
	'time_to_new_customer': "more customers",
	'money_multiplier': "This increase the mons"
	
}
@onready var cost = {
	'capacity': "Cost 100",
	'time_to_unhappy': "Cost 50",
	'time_to_new_customer': "Cost 90",
	'money_multiplier': "Cost 150"
}

func start_end() -> void:
	active = true
	$Background.show()
	$ItemOne.show()
	$ItemTwo.show()
	$ItemThree.show()
	$Sign.show()
	
func hide_end() -> void:
	active = false
	$Background.hide()
	$ItemOne.hide()
	$ItemTwo.hide()
	$ItemThree.hide()
	$Sign.hide()
	
func _shop_finished() -> void:
	hide_end()
	shop_done.emit()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_end()
	for child in get_children():
		if child is ItemCard:
			child.item = GameManager.upgrades.keys().pick_random()
			child.item_sprite.texture = icons.get(child.item)
			child.item_cost.text = cost.get(child.item)
			child.item_texts.text = texts.get(child.item)
			child.item_texts.autowrap_mode = TextServer.AUTOWRAP_WORD
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("test") and active:
		_shop_finished()
			
