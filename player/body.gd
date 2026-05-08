class_name PlayerBody extends RigidBody2D

@export var left_arm : Arm
@export var right_arm : Arm

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_joint(left_arm)
	make_joint(right_arm)

func make_joint(arm : Arm):
	var joint := PinJoint2D.new()
	joint.softness = 10
	joint.node_a = self.get_path()
	joint.node_b = arm.back_arm.get_path()
	add_child(joint)
