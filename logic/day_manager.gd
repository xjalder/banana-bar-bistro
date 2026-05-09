extends Node

var money: int
@export var curr_lv: Enums.Level

var level_limit: Dictionary = {
	Enums.Level.LV1: 1, # one monkey order completed to finish day 
	Enums.Level.LV2: 2, #etc
	Enums.Level.LV3: 3,
	Enums.Level.LV4: 3,
	Enums.Level.LV5: 4
}

signal change_map(curr_lv: Enums.Level)

var monkeys_fed : int = 0


func _iterate_monkey_fed() ->void:
	monkeys_fed += 1
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_lv = Enums.Level.LV1
	SignalBus.end_day.connect(_next_level)
	money = 0

func get_lv() -> Enums.Level:
	return curr_lv


func _next_level() -> void:
	if curr_lv == Enums.Level.LV5:
		curr_lv = Enums.Level.LV1
	else:
		curr_lv += 1

func _end_day() -> void:
	SignalBus.end_lv.emit()
	


func _start_next_day() -> void:
	_next_level()
	change_map.emit(curr_lv)  #emit new level
	
func get_lv_lim() -> int:
	return level_limit.get(curr_lv)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#send signal to change to next level
	if monkeys_fed >= get_lv_lim():
		_end_day()
	
	
