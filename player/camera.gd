extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var relative_mouse_pos := get_viewport().get_mouse_position()
	var viewport_rect := get_viewport_rect()
	
	var x_offset_change : float
	if relative_mouse_pos.x > viewport_rect.end.x * 0.7:
		x_offset_change = 200
	elif relative_mouse_pos.x < viewport_rect.end.x * 0.3:
		x_offset_change = -200
	elif offset.x != 0:
		x_offset_change = 0
	
	var y_offset_change : float
	if relative_mouse_pos.y > viewport_rect.end.y * 0.8:
		y_offset_change = 100
	elif relative_mouse_pos.y < viewport_rect.end.x * 0.2:
		y_offset_change = -100
	elif offset.x != 0:
		y_offset_change = 0
	
	if offset == Vector2.ZERO and Vector2(x_offset_change, y_offset_change) == Vector2.ZERO:
		return
	
	var tween := create_tween()
	tween.tween_property(self, "offset", Vector2(x_offset_change, y_offset_change), 2)
	tween.play()
