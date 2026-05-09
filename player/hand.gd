class_name Hand extends RigidBody2D

var grabbing : bool
var arm_action : String
var held_item : Sprite2D
var droppable_scene : PackedScene = preload("res://logic/Droppable.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	InputHandler.left_arm_interact_pressed.connect(_drop_item_left)


func _drop_item_left() -> void:
	if PlayerManager.left_hand_holding == Enums.Holdables.NONE:
		return
	var dropped : Droppable= droppable_scene.instantiate()
	PlayerManager.add_child(dropped)
	dropped._create_droppable_no_sprite(PlayerManager.left_hand_holding, self.position)
	PlayerManager.left_hand_holding = Enums.Holdables.NONE
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !grabbing:
		var local_pos := (get_global_mouse_position() - global_position).normalized()
		apply_central_impulse(local_pos * 300)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(arm_action):
		var local_pos := (get_global_mouse_position() - global_position).normalized()
		apply_central_impulse(local_pos * 1000)
		grabbing = true
		sprite_2d.texture = load("res://assets/player/Hand_Closed.png")
		
	elif event.is_action_released(arm_action):
		grabbing = false
		if freeze:
			SignalBus.ungrapple.emit(arm_action == "left_arm")
			freeze = false
		sprite_2d.texture = load("res://assets/player/Hand_Open.png")
		
