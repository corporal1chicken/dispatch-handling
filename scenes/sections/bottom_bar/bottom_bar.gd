extends Panel

var styles: Dictionary = {
	red = preload("res://assets/icons/call/red.png"),
	green = preload("res://assets/icons/call/green.png"),
	white = preload("res://assets/icons/call/white.png"),
	orange = preload("res://assets/icons/call/orange.png")
}

func _ready():
	Signals.call_recieved.connect(_on_new_call)
	Signals.call_finished.connect(_on_call_finished)

func _on_call_pressed():
	Signals.call_accepted.emit()
	$call.texture_normal = styles.orange

func _on_new_call(_call_data):
	$call.texture_normal = styles.red

func _on_call_finished():
	$call.texture_normal = styles.green
