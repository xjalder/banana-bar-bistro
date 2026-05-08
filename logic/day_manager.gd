extends Node

enum Level {LV1, LV2, LV3, LV4, LV5}
var level_limit: Dictionary = {
	Level.LV1: 1, # one monkey order completed to finish day 
	Level.LV2: 2, #etc
	Level.LV3: 3,
	Level.LV4: 3,
	Level.LV5: 4
}

var monkeys_fed : int

@export var curr_level : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_level = LV1
	

func next_level() -> void:
	if curr_level == Level.LV1:
		curr_level = Level.LV2
	elif curr_level == Level.LV2:
		curr_level = Level.LV3
	elif curr_level == Level.LV3:
		curr_level = Level.LV4
	elif curr_level == Level.LV4:
		curr_level = Level.LV5

func _start_next_day() -> void:
	

func get_level() -> int:
	return curr_level

func get_lv_lim() -> int:
	return day_limit.get(curr_level)
	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	#send signal to change to next level
	#if signal recieved from monkey  going away
		#monkey_fed += 1 CALL A MONKEY INCREMENT FUNCTION ON CONNNECT THEN CHECK?
		#if monkey_fed == get_lv_lim():
			#start_next_day()
			
	
	
	
