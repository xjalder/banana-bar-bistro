class_name OrderManager extends Control

var customers : Array[MonkeyCustomer]
var order_dict : Dictionary[MonkeyCustomer, OrderCard]

var recipes : Dictionary[Enums.Order, Array] = {
	Enums.Order.BANANA : [preload("res://assets/banana hut/banana.png"), null],
	Enums.Order.BANANA_BREAD : [preload("res://assets/banana hut/banana.png"), preload("res://assets/banana hut/Bread.png")],
	Enums.Order.BANANA_SMOOTHIE : [preload("res://assets/banana hut/banana.png"), preload("res://assets/banana hut/MilkBottle.webp")],
	Enums.Order.BANANA_ICECREAM : [preload("res://assets/banana hut/banana.png"), preload("res://assets/Ice.webp")],
}

const order_scene : PackedScene = preload("res://ui/order_card.tscn")

const monkey_names : Array[String] = [
	"Bongo", "Coco", "Mango", "Zazu", "Bubbles", "Chimp", "Rascal", "Banjo",
	"Noodle", "Waffles", "Scrappy", "Tiki", "Samba", "Peanut", "Ziggy", "Louie",
	"Doodle", "Kiki", "Rumble", "Patches", "Fizz", "Wobble", "Chomper", "Biscuit",
	"Tarzan", "Gizmo", "Pumba", "Ringo", "Bobo", "Squirt", "Jojo", "Clover",
	"Tango", "Sprout", "Pixel", "Skipper", "Nana", "Dingo", "Marble", "Pudding"
]

func _ready() -> void:
	anchor_left = 0.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	offset_left = 0.0
	offset_top = 0.0
	offset_right = 0.0
	offset_bottom = 0.0
	SignalBus.new_customer.connect(_handle_customer_arrive)
	SignalBus.happy_customer.connect(func(customer: MonkeyCustomer) -> void: _handle_customer_leave(customer, true))
	SignalBus.unhappy_customer.connect(func(customer: MonkeyCustomer) -> void: _handle_customer_leave(customer, false))
	
const MAX_ORDERS := 5
const CARD_SPACING := 125

func _handle_customer_arrive(customer: MonkeyCustomer) -> void:
	if customers.size() >= MAX_ORDERS:
		return
	customers.append(customer)
	var order_card: OrderCard = order_scene.instantiate()
	order_card.monkey = customer
	add_child(order_card)
	order_card.monkey_name.text = monkey_names.pick_random()
	order_card.left_item.texture = recipes.get(customer.order)[0]
	order_card.right_item.texture = recipes.get(customer.order)[1]
	order_dict[customer] = order_card
	order_card._start()
	order_card.scale *= 0.25
	order_card.pivot_offset = -order_card.size * 3
	order_card.pivot_offset += Vector2(25, 200)
	_reposition_cards()

func _handle_customer_leave(customer: MonkeyCustomer, is_happy: bool) -> void:
	customers.erase(customer)
	if order_dict.has(customer):
		order_dict[customer].queue_free()
		order_dict.erase(customer)
	_reposition_cards()

func _reposition_cards() -> void:
	var card : OrderCard = order_dict.values()[0] if order_dict.size() > 0 else null
	if not card:
		return
	var card_height: float = card.size.y * card.scale.y
	var card_width: float = card.size.x * card.scale.x
	var i := 0
	for customer in customers:
		if is_instance_valid(customer) and order_dict.has(customer):
			var c: OrderCard = order_dict[customer]
			c.anchor_left = 1.0
			c.anchor_right = 1.0
			c.anchor_top = 0.0
			c.anchor_bottom = 0.0
			c.offset_left = -card_width
			c.offset_right = 0.0
			c.offset_top = i * (card_height + CARD_SPACING)
			c.offset_bottom = c.offset_top + card_height
			i += 1
