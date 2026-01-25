extends Panel

@onready var fields: Control = $fields

var fields_completed: int = 0
var current_call_data: Dictionary
var initial_report_data: Dictionary

var required: int = 0
var total: int = 0

# Godot Specific Functions
func _ready():
	Signals.call_recieved.connect(_on_call_recieved)
	Signals.field_lock_change.connect(_on_field_lock_change)
	Signals.call_accepted.connect(_on_call_accepted)

	total = $fields.get_child_count()

# UI Functions
func _on_send_pressed():
	fields_completed = 0
	var data: Dictionary = {}
	
	for field in fields.get_children():
		var response = field.retrieve_field()
		
		if field.required and response == null:
			print("%s cannot be empty" % field.key)
			break
		else:
			fields_completed += 1
		
		data[field.key] = response
	
	if fields_completed == fields.get_child_count():
		initial_report_data = data
		Signals.report_sent.emit()

func _on_clear_pressed() -> void:
	for field in fields.get_children():
		field.reset_field()

func _on_lock_all_pressed():
	for field in fields.get_children():
		field.lock_field()

# Signal Functions
func _on_call_recieved(call_data: Dictionary):
	current_call_data = call_data
	$id.text = call_data.external_id

func _on_field_lock_change(type: String):
	match type:
		"locked":
			required += 1
		"unlocked":
			required -= 1
	print("%d, %d" % [required, total])
	if required == total:
		$buttons/HBoxContainer/send.disabled = false
	else:
		$buttons/HBoxContainer/send.disabled = true
		
func _on_call_accepted():
	$no_incident.visible = false
