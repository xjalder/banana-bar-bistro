class_name SFXManager extends AudioStreamPlayer

var rustles : Array[String] = ["res://assets/SFX/rustle.mp3", "res://assets/SFX/rustle2.mp3", "res://assets/SFX/rustle1.mp3"]


func _ready():
	
	SignalBus.play_grapple_sound.connect(_play_grapple)
	
func _play_grapple() -> void:
	var chance : float = randf()
	if chance > 0.5:
		return
	stream = load(rustles.pick_random())
	set_volume_db(-5)

	play()
	
