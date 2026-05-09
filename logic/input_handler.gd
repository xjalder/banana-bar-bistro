extends Node

signal left_arm_interact_pressed
signal right_arm_interact_pressed

var q_timer : Timer
var e_timer : Timer

func _ready() -> void:
	q_timer = setup_timer()
	e_timer = setup_timer()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_arm"):
		if not q_timer.is_stopped():
			left_arm_interact_pressed.emit()
		else:
			q_timer.start()
	elif event.is_action_pressed("right_arm"):
		if not e_timer.is_stopped():
			right_arm_interact_pressed.emit()
		else:
			e_timer.start()

func setup_timer() -> Timer:
	var timer := Timer.new()
	timer.autostart = false
	timer.wait_time = 0.3
	timer.one_shot = true
	add_child(timer)
	return timer
