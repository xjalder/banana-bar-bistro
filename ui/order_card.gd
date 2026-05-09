class_name OrderCard extends Control

@onready var monkey_name : Label = $Label
@onready var patience : AnimatedSprite2D = $AnimatedSprite2D
@onready var left_item : Sprite2D = $LeftItem
@onready var right_item : Sprite2D = $RightItem
var monkey : MonkeyCustomer

func _start() -> void:
	patience.sprite_frames.set_animation_speed("default", patience.sprite_frames.get_frame_count("default") / float(monkey.time_to_unhappy))
	patience.play("default")
