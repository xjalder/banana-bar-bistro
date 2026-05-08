class_name Hand extends RigidBody2D

var grabbing : bool
var arm_action : String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !grabbing:
		var local_pos := (get_global_mouse_position() - global_position).normalized()
		apply_central_impulse(local_pos * 100)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(arm_action):
		var local_pos := (get_global_mouse_position() - global_position).normalized()
		apply_central_impulse(local_pos * 1000)
		grabbing = true
	elif event.is_action_released(arm_action):
		grabbing = false
		if freeze:
			SignalBus.ungrapple.emit()
			freeze = false
		
