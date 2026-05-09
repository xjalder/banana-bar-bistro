extends Area2D
@onready var banana_hut: BananaHut = $".."

var hands : Array[Hand] = []

func _ready() -> void:
	body_entered.connect(body_enter)
	body_exited.connect(body_exit)
	
func _process(delta: float) -> void:
	for hand in hands:
		var holdable : Enums.Holdables = Enums.Holdables.NONE
		if hand.arm_action == "left_arm":
			holdable = PlayerManager.left_hand_holding
		elif hand.arm_action == "right_arm":
			holdable = PlayerManager.right_hand_holding
	
		if banana_hut._remove_monkey_with_order(holdable):
			if hand.arm_action == "left_arm":
				PlayerManager.left_hand_holding = Enums.Holdables.NONE
			elif hand.arm_action == "right_arm":
				PlayerManager.right_hand_holding = Enums.Holdables.NONE
			
			if is_instance_valid(hand.held_item):
				hand.held_item.queue_free()
	
func body_enter(body : Node):
	if body is Hand:
		hands.append(body)

func body_exit(body : Node):
	if body is Hand: 
		hands.erase(body)
