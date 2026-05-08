class_name PlayerBody extends RigidBody2D

@export var left_arm : Arm
@export var right_arm : Arm

# The angle you want the body to maintain (in radians)
var target_angle = 0.0
# How strongly the gyroscope corrects the rotation
var gyroscope_strength = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_joint(left_arm)
	make_joint(right_arm)

func make_joint(arm : Arm):
	var joint := PinJoint2D.new()
	joint.softness = 2
	joint.node_a = self.get_path()
	joint.node_b = arm.back_arm.get_path()
	joint.position = Vector2(-5, 0) if arm == left_arm else Vector2(5,0)
	add_child(joint)

func _integrate_forces(state):
	# Calculate difference, normalized to -PI to PI
	var angle_diff = wrapf(target_angle - state.transform.get_rotation(), -PI, PI)
	
	# Apply torque to counteract rotation
	# Proportional to angular velocity for damping
	angular_velocity = angle_diff * gyroscope_strength
