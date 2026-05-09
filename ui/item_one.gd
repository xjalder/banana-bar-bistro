extends Button

var item : String = 'capacity'

#handles individial items
func _send_buy(item : String) -> void:
	if $OnOff.frame == 2:
		return
	
	var bought : bool = GameManager.buy_item(item)
	if bought:
		$Sold.show()
		$OnOff.frame = 2
	#error message must be shown or something
	
func _hover_over() -> void:
	if $OnOff.frame != 2:
		$OnOff.frame = 1
	

func _exit() -> void:
	if $OnOff.frame != 2:
		$OnOff.frame = 0
	
#each individual enum
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OnOff.frame = 0
	$Sold.hide()
	self.pressed.connect(_send_buy.bind(item))
	self.mouse_entered.connect(_hover_over)
	self.mouse_exited.connect(_exit)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
