extends Button

signal next_pressed

func _next() -> void:
	next_pressed.emit()
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_next)
