class_name BananaHut extends Node2D

var monkey_scene : PackedScene = preload("/Users/ben/Desktop/banana-bar-bistro/map/banana hut/MonkeyCustomer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var monkey : Node = monkey_scene.instantiate()
	var relative_to_parent := self.position
	var sprite_size :=  self.scale
	for i in range(3):
		add_child(monkey)
		
	print(relative_to_parent, sprite_size)
	add_child(monkey)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
