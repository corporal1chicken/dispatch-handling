extends Panel

@onready var fields: Control = $fields

var fields_completed: int = 0
var current_call_data: Dictionary

# Godot Specific Functions
func _ready():
	Signals.call_recieved.connect(_on_call_recieved)

# UI Functions
func _on_send_pressed():
	fields_completed = 0
	
	for field in fields.get_children():
		if not field.required: continue
		
		if field.retrieve_field() == "None":
			print("Field cannot be empty")
			break
		else:
			fields_completed += 1
	
	if fields_completed == fields.get_child_count():
		print("Form completed")
	
func _on_clear_pressed() -> void:
	for field in fields.get_children():
		field.reset_field()

# Signal Functions
func _on_call_recieved(call_data: Dictionary):
	current_call_data = call_data
	$id.text = call_data.external_id
