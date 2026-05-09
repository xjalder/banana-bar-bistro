extends Node

var money: int

enum Level {LV1, LV2, LV3, LV4, LV5}
@export var curr_lv: Level

var level_limit: Dictionary = {
	Level.LV1: 1, # one monkey order completed to finish day 
	Level.LV2: 2, #etc
	Level.LV3: 3,
	Level.LV4: 3,
	Level.LV5: 4
}

signal change_map(curr_lv: Level)

var monkeys_fed : int = 0


func _iterate_monkey_fed() ->void:
	monkeys_fed += 1
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_lv = Level.LV1
	money = 0
	#MonkeyCustomer.connect(_iterate_monkey_fed)
	

func get_lv() -> Level:
	return curr_lv


func _next_level() -> void:
	if curr_lv == Level.LV5:
		curr_lv = Level.LV1
	else:
		curr_lv += 1

func _start_next_day() -> void:
	_next_level()
	change_map.emit(curr_lv)  #emit new level
	
func get_lv_lim() -> int:
	return level_limit.get(curr_lv)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#send signal to change to next level
	if monkeys_fed >= get_lv_lim():
		_start_next_day()
	
	
