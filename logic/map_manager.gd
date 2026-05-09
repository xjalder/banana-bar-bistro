extends Node2D

signal load_completed(completed: bool)
var completed : bool = false

func _load_map()->void:
	
	
	completed = true
	load_completed.emit()
	
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayManager.connect(_load_map())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
