extends TextureRect

@onready var day : Label = $DayLabel
@onready var coin : Label = $CoinLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day.text += str(DayManager.curr_lv)
	coin.text += str(GameManager.money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
