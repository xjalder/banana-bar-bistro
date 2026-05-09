extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#fit to screen?
	$MoneyCount.text = str(GameManager.money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MoneyCount.text = str(GameManager.money)
	print(GameManager.money)
