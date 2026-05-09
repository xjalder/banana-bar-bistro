extends AudioStreamPlayer

var songs : Array[String] = ["res://assets/music/music1.mp3", "res://assets/music/music2.mp3", "res://assets/music/music3.mp3"]

var timer : Timer

func _ready():
	# Plays the music if it wasn't set to Autoplay
	stream = load(songs.pick_random())
	play()
	
	timer = Timer.new()
	timer.wait_time = randi_range(1,10)
	timer.autostart = true
	

func _on_finished():
	# Restarts the music when it finishes if looping isn't enabled in import
	stream = load(songs.pick_random())
	play()
