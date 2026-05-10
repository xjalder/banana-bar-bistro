class_name OrderCard extends Control

@onready var monkey_name : Label = $Label
@onready var patience : AnimatedSprite2D = $AnimatedSprite2D
@onready var left_item : Sprite2D = $LeftItem
@onready var right_item : Sprite2D = $RightItem
var monkey : MonkeyCustomer

func _start() -> void:
	var fps := patience.sprite_frames.get_frame_count("default") / float(monkey.time_to_unhappy)
	patience.sprite_frames.set_animation_speed("default", fps)
	patience.play("default")
	patience.frame = 0

func _process(delta: float) -> void:
	if patience.frame >= 30:
		patience.frame = 30
		patience.stop()
