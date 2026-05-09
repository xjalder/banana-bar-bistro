class_name PlayerBody extends RigidBody2D

@export var left_arm : Arm
@export var right_arm : Arm
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

# The angle you want the body to maintain (in radians)
var target_angle = 0.0
# How strongly the gyroscope corrects the rotation
var gyroscope_strength = 0.3

var last_global_pos : Vector2

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
	
	angular_velocity = angle_diff * gyroscope_strength

func _physics_process(delta: float) -> void:
	if last_global_pos == null:
		last_global_pos = global_position
		return
	
	if last_global_pos.x < global_position.x - 2:
		sprite.flip_h = false
	elif last_global_pos.x > global_position.x + 2:
		sprite.flip_h = true
	
	last_global_pos = global_position
