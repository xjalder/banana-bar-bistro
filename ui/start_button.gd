extends Button

func _hover_over() -> void:
	$StartCard.frame = 1
	
func _leave_butt() -> void:
	$StartCard.frame = 0
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartCard.frame = 0
	self.mouse_entered.connect(_hover_over)
	self.mouse_exited.connect(_leave_butt)
