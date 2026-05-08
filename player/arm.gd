class_name Arm extends Node2D

@export var arm_type : Enums.ArmType
@export var back_arm : RigidBody2D

@onready var hand := $Hand

@onready var arm_label := $Backarm/Label # DO WE WANT TODO

func _ready() -> void:
	# Also part of the helper text TODO
	if arm_type == Enums.ArmType.Left:
		hand.arm_action = "left_arm"
		arm_label.text = "Q"
	elif arm_type == Enums.ArmType.Right:
		arm_label.text = "E"
		hand.arm_action = "right_arm"
