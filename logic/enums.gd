extends Node

enum ArmType {Left, Right}

enum Order {BANANA, BANANA_BREAD, BANANA_SMOOTHIE, BANANA_ICECREAM}

enum Holdables {BANANA, BANANA_BREAD, BANANA_SMOOTHIE, BANANA_ICECREAM, BREAD, ICE, MILK, NONE}

var OrderCost :Dictionary[Order, int] = {
	Order.BANANA : 50, Order.BANANA_BREAD : 90, Order.BANANA_SMOOTHIE : 120
	}

enum Level {LV1, LV2, LV3, LV4, LV5}
