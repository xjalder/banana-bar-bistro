class_name Swingable extends Area2D

var hands_colliding : Array[Hand] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(handle_body_enter)
	body_exited.connect(handle_body_exit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for hand in hands_colliding:
		if hand.grabbing and not hand.freeze:
			hand.set_deferred("freeze", true)
			SignalBus.grapple.emit()

func handle_body_enter(body : Node) -> void:
	if body is Hand:
		hands_colliding.append(body)

func handle_body_exit(body : Node) -> void:
	if body is Hand:
		hands_colliding.erase(body)
