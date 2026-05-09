extends Node2D
@onready var left_eye: Sprite2D = $FaceSprite/LeftEye
@onready var right_eye: Sprite2D = $FaceSprite/RightEye
@onready var face_sprite: Sprite2D = $FaceSprite

var types: Array[Enums.Holdables] = [0, 0]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


func _add_holdable_to_face(holding : Enums.Holdables) -> void:
	if (not left_eye.texture):
		left_eye.texture = load("res://assets/banana hut/banana.png")
		var left_eye_size : Vector2 =left_eye.get_rect().size
		var face_size : Vector2 = face_sprite.get_rect().size
		left_eye.scale= Vector2(face_size.x / (5 *left_eye_size.x), face_size.y/ (5 * left_eye_size.y))
		types[0] = holding
	elif (not right_eye.texture):
		right_eye.texture = load("res://assets/banana hut/banana.png")
		var right_eye_size : Vector2 =right_eye.get_rect().size
		var face_size : Vector2 = face_sprite.get_rect().size
		right_eye.scale= Vector2(face_size.x / (5 *right_eye_size.x), face_size.y/ (5 * right_eye_size.y))
		types[1]= holding
	else:
		_make_product()
		left_eye.texture = null
		right_eye.texture = null
		types = [0,0]
		
		
func _make_product() -> void:
	var product : Enums.Holdables
	if types == [Enums.Holdables.BANANA, Enums.Holdables.BANANA]:
		_spawn_product(Enums.Holdables.BANANA)
	elif types == [Enums.Holdables.BANANA, Enums.Holdables.BREAD] or types ==  [Enums.Holdables.BREAD, Enums.Holdables.BANANA]:
		_spawn_product(Enums.Holdables.BANANA_BREAD)
	elif types == [Enums.Holdables.BANANA, Enums.Holdables.MILK] or types == [Enums.Holdables.MILK, Enums.Holdables.BANANA]:
		_spawn_product(Enums.Holdables.BANANA_SMOOTHIE)
	elif types == [Enums.Holdables.BANANA_SMOOTHIE, Enums.Holdables.ICE] or types == [Enums.Holdables.ICE, Enums.Holdables.BANANA_SMOOTHIE]:
		_spawn_product(Enums.Holdables.BANANA_ICECREAM) 
	
	
func _spawn_product(product : Enums.Holdables) -> void:
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("spawn_monkey"):
		_add_holdable_to_face(Enums.Holdables.BANANA)
	
	
