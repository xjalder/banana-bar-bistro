class_name CollectArea extends Area2D

var holdable : Enums.Holdables = Enums.Holdables.NONE
var texture : Texture
var hands : Array[Hand]

signal fruit_taken

func _ready() -> void:
	body_entered.connect(body_enter)
	body_exited.connect(body_exit)
	InputHandler.left_arm_interact_pressed.connect(handle_left_input)
	InputHandler.right_arm_interact_pressed.connect(handle_right_input)
	
func body_enter(body : Node) -> void:
	if body is Hand:
		hands.append(body)

func body_exit(body : Node) -> void:
	if body is Hand:
		hands.erase(body)

func handle_left_input() -> void:
	if get_parent() is Spawner and get_parent().num_fruits <= 0:
		return
	
	if hands.is_empty() or !_has_empty_hand(true) or PlayerManager.left_hand_holding != Enums.Holdables.NONE:
		return
		
	var fruit_sprite := Sprite2D.new()
	fruit_sprite.texture = texture
	fruit_sprite.scale *=  2
	var hand = _get_valid_hand(true)
	hand.add_child(fruit_sprite)
	hand.held_item = fruit_sprite
	PlayerManager.left_hand_holding = holdable
	fruit_taken.emit()

func handle_right_input() -> void:
	if get_parent() is Spawner and get_parent().num_fruits <= 0:
		return
		
	if hands.is_empty() or !_has_empty_hand(false) or PlayerManager.right_hand_holding != Enums.Holdables.NONE:
		return
		
	var fruit_sprite := Sprite2D.new()
	fruit_sprite.texture = texture
	fruit_sprite.scale *= 2
	var hand = _get_valid_hand(false)
	hand.add_child(fruit_sprite)
	hand.held_item = fruit_sprite
	PlayerManager.right_hand_holding = holdable
	fruit_taken.emit()

func _has_empty_hand(is_left : bool) -> bool:
	
	for hand in hands:
		if hand.arm_action == "left_arm" and PlayerManager.left_hand_holding == Enums.Holdables.NONE and is_left \
			or hand.arm_action == "right_arm" and PlayerManager.right_hand_holding == Enums.Holdables.NONE and not is_left:
			return true
	return false

func _get_valid_hand(is_left : bool) -> Hand:
	var valid_hand = hands.get(0)
	if valid_hand.arm_action == "left_arm" and PlayerManager.left_hand_holding == Enums.Holdables.NONE and is_left:
		return valid_hand
	elif valid_hand.arm_action == "right_arm" and PlayerManager.right_hand_holding == Enums.Holdables.NONE and not is_left:
		return valid_hand
		
	for hand in hands:
		if hand.arm_action == "left_arm" and PlayerManager.left_hand_holding == Enums.Holdables.NONE and is_left:
			return hand
		elif hand.arm_action == "right_arm" and PlayerManager.right_hand_holding == Enums.Holdables.NONE and not is_left:
			return hand
	
	return null
