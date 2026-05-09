class_name CollectArea extends Area2D

var growable : Enums.Growables = Enums.Growables.None
var texture : Texture
var hands : Array[Hand]

signal fruit_taken

func _ready() -> void:
	body_entered.connect(body_enter)
	body_exited.connect(body_exit)
	
func body_enter(body : Node) -> void:
	if body is Hand:
		hands.append(body)

func body_exit(body : Node) -> void:
	if body is Hand:
		hands.erase(body)
		
func _get_holdable_from_growable() -> Enums.Holdables:
	match growable:
		Enums.Growables.Banana: return Enums.Holdables.BANANA
		Enums.Growables.Milk: return Enums.Holdables.MILK
		Enums.Growables.Ice: return Enums.Holdables.ICE
		Enums.Growables.Bread: return Enums.Holdables.BREAD
	return Enums.Holdables.NONE

func _input(event: InputEvent) -> void:
	if hands.is_empty() or get_parent().num_fruits <= 0 or !_has_empty_hand():
		return
		
	if event.is_action_pressed("interact"):
		var fruit_sprite := Sprite2D.new()
		fruit_sprite.texture = texture
		fruit_sprite.scale *= 0.05
		var hand = _get_valid_hand()
		hand.add_child(fruit_sprite)
		hand.held_item = fruit_sprite
		if hand.arm_action == "left_arm":
			PlayerManager.left_hand_holding = _get_holdable_from_growable()
		elif hand.arm_action == "right_arm":
			PlayerManager.right_hand_holding = _get_holdable_from_growable()
		fruit_taken.emit()

func _has_empty_hand() -> bool:
	for hand in hands:
		if hand.arm_action == "left_arm" and PlayerManager.left_hand_holding == Enums.Holdables.NONE \
			or hand.arm_action == "right_arm" and PlayerManager.right_hand_holding == Enums.Holdables.NONE:
			return true
	return false

func _get_valid_hand() -> Hand:
	var valid_hand = hands.get(0)
	if valid_hand.arm_action == "left_arm" and PlayerManager.left_hand_holding == Enums.Holdables.NONE:
		return valid_hand
	elif valid_hand.arm_action == "right_arm" and PlayerManager.right_hand_holding == Enums.Holdables.NONE:
		return valid_hand
		
	for hand in hands:
		if hand.arm_action == "left_arm" and PlayerManager.left_hand_holding == Enums.Holdables.NONE:
			return hand
		elif hand.arm_action == "right_arm" and PlayerManager.right_hand_holding == Enums.Holdables.NONE:
			return hand
	
	return null
