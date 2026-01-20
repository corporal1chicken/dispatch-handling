extends Node

# Starts a new call request. Player must accept the call
# Generates call data + changes UI elements
signal call_recieved(call_data: Dictionary)
# Starts when a call is accepted by the player.
signal call_accepted()
# Starts when the current calls ends.
signal call_finished()

signal report_sent()

signal field_lock_change(type: String)
