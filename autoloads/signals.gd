extends Node

#signal call_started(call_data: Dictionary)
#signal call_accepted()

# Starts a new call request. Player must accept the call
# Generates call data + changes UI elements
signal call_recieved(call_data: Dictionary)
# Starts when a call is accepted by the player.
signal call_accepted()
# Starts when the current calls ends.
signal call_finished()
