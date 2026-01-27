extends Node

signal call_recieved(call_data: Dictionary)
signal call_accepted()
signal call_finished()

signal report_sent()

signal field_lock_change(type: String)

signal second_tick(timestamp: String)

signal change_screen(old_name: String, new_name: String)

signal shift_started()
