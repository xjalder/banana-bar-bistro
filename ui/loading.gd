extends Control

const main_scene : String = "res://logic/main.tscn"
@onready var spinner : TextureRect = $TextureRect
var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 2
	timer.one_shot = true
	timer.autostart = false
	timer.timeout.connect(_start)
	add_child(timer)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spinner.rotation -= 0.1

func _start() -> void:
	SceneManagerTscn.change_scene(get_tree().current_scene, main_scene)
