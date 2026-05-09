extends Control

func _start_end_screen(curr_lv : Enums.Level) -> void:
	$EndDay.start_screen(curr_lv)

func _start_shop() -> void:	
	$BuyScreen.start_end()

func _next_day() -> void:
	SignalBus.end_day.emit()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.end_lv.connect(_start_end_screen)
	$EndDay.screen_done.connect(_start_shop)
	$BuyScreen.shop_done.connect(_next_day)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_monkey"):
		_start_end_screen(Enums.Level.LV1)
