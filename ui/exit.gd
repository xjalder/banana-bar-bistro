extends Button

signal close_shop

func _end_shop() -> void:
	close_shop.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_end_shop)
