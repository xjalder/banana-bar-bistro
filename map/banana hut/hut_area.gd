extends Area2D
@onready var banana_hut: BananaHut = $".."

func _ready() -> void:
	body_entered.connect(_on_area_2d_body_entered)
	
func _on_area_2d_body_entered(body):
	banana_hut._remove_monkey_with_order(banana_hut.left_hand)
