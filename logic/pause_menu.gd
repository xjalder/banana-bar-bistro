extends CanvasLayer

var paused : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		paused = not paused
		visible = not visible
		get_tree().paused = paused
