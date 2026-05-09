class_name Collector extends Area2D

signal collect_fruit(fruit : Enums.Holdables)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(body_enter)

func body_enter(body : Droppable):
	collect_fruit.emit(body.type)
	body.queue_free()
