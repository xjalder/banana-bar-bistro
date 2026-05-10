extends Node

signal grapple(is_left : bool)
signal ungrapple(is_left : bool)
signal falling_held
signal falling_released
signal new_customer(monkey : MonkeyCustomer)
signal happy_customer(monkey : MonkeyCustomer)
signal unhappy_customer(monkey : MonkeyCustomer)
signal add_money(amount : int)
signal end_day
signal end_lv(curr_lv: Enums.Level)
signal play_grapple_sound
signal play_mixer_sound
signal play_win_sound
