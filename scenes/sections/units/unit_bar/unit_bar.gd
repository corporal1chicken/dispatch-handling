extends Panel

enum Status{AVAILABLE, UNAVAILABLE, EN_ROUTE, ON_SCENE}

@export var title: String = "None Set"
@export var tags: String = "[None Set]"
@export var icon: Texture2D
@export var current_status: Status = Status.AVAILABLE

# Built In Functions
func _ready():
	pass

# Button Functions	
func _on_tags_mouse_entered() -> void:
	$misc/label.visible = true

func _on_tags_mouse_exited() -> void:
	$misc/label.visible = false

func _on_extra_pressed() -> void:
	$extra/popup.visible = not $extra/popup.visible
	$extra.release_focus()
	
func _on_popup_mouse_exited() -> void:
	pass # Replace with function body.

func _on_extra_option_pressed():
	pass

# Main Functions
func _hold():
	# Reserves a unit, tells them to hold position
	pass
	
func _role():
	# Change what role they are in a call
	# e.g. Lead/Primary, Backup, Traffic etc
	pass
	
func _mode():
	# Response type, e.g. lights, no lights etc
	pass
	
func _dispatch():
	# Assign/unassign from call
	pass
