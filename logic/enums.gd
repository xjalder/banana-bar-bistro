extends Node

enum ArmType {Left, Right}

enum Growables {None, Banana, Bread, Ice, Milk}

enum Order {BANANA, BANANA_BREAD, BANANA_SMOOTHIE}

enum Holdables {BANANA, BANANA_BREAD, BANANA_SMOOTHIE, BREAD, ICE, MILK, NONE}

var OrderCost :Dictionary[Order, int] = {
	Order.BANANA : 50, Order.BANANA_BREAD : 90, Order.BANANA_SMOOTHIE : 120
	}
