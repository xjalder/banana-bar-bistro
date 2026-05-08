class_name PlayerBody extends RigidBody2D

@export var left_arm : Arm
@export var right_arm : Arm

var num_arms_grappled : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.grapple.connect(on_grapple)
	SignalBus.ungrapple.connect(on_ungrapple)
	
	make_joint(left_arm)
	make_joint(right_arm)
	
func on_grapple() -> void:
	num_arms_grappled = min(2, num_arms_grappled + 1)
	if num_arms_grappled >= 1:
		mass = 2.5
	
func on_ungrapple() -> void:
	num_arms_grappled = max(0, num_arms_grappled - 1)
	if num_arms_grappled == 0:
		mass = 500

func make_joint(arm : Arm):
	var joint := PinJoint2D.new()
	joint.softness = 10
	joint.node_a = self.get_path()
	joint.node_b = arm.back_arm.get_path()
	add_child(joint)
