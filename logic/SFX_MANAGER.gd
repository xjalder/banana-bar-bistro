class_name SFXManager
extends AudioStreamPlayer

var rustles : Array[String] = [
	"res://assets/SFX/rustle.mp3",
	"res://assets/SFX/rustle2.mp3",
	"res://assets/SFX/rustle1.mp3"
]

var monkey_sounds : Array[String] = [
	"res://assets/SFX/rustle.mp3",
	"res://assets/SFX/ambient.mp3"
	
]

var timer : Timer


func _ready() -> void:
	SignalBus.play_grapple_sound.connect(_play_grapple)
	SignalBus.play_mixer_sound.connect(_play_mixer)
	SignalBus.play_win_sound.connect(_play_win)

	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)

	timer.timeout.connect(_play_random_rustle)

	_start_random_timer()


func _start_random_timer() -> void:
	timer.wait_time = randf_range(25.0, 50.0)
	timer.start()

func _play_win() -> void:
	stream = load("res://assets/SFX/finishday1.mp3")
	play()

func _play_random_rustle() -> void:
	stream = load(monkey_sounds.pick_random())
	volume_db = -5

	play()

	# start next random timer
	_start_random_timer()

func _play_mixer() -> void:
	stream = load("res://assets/SFX/food cooker1.mp3")
	
	play()
	
	
func _play_grapple() -> void:
	var chance : float = randf()

	if chance > 0.5:
		return

	stream = load(rustles.pick_random())
	volume_db = -5

	play()
