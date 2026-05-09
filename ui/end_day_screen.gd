extends Control

signal screen_done()

var is_active : bool = false

func start_screen(curr_lv:Enums.Level) -> void:
	$Money.text = str(GameManager.money)
	$"Level Card".text = str(curr_lv +1) #risky
	
	_show_all()
	
func _show_all() -> void:
	is_active = true
	$EndScreen.show()
	$"Level Card".show()
	$Coin.show()
	$Card.show()
	$Money.show()

func _hide_all() -> void:
	is_active = false
	$EndScreen.hide()
	$"Level Card".hide()
	$Card.hide()
	$Coin.hide()
	$Money.hide()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hide_all()
	$Money.autowrap_mode = TextServer.AUTOWRAP_WORD
	$"Level Card".autowrap_mode = TextServer.AUTOWRAP_WORD
	start_screen(Enums.Level.LV1)

func _go_shop() -> void:
	_hide_all()
	screen_done.emit()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("test") && is_active:
		_go_shop()
		
	
