extends Panel

@export_category("Input Field")
@export var title: String = "None Set"
@export var placeholder_text: String = "None Set"
@export var required: bool = false

# Godot Specific Functions
func _ready():
	$title.text = title
	$field.placeholder_text = placeholder_text
	$required.visible = true if required else false
	
# UI Functions
func _on_field_mouse_entered() -> void:
	$field.grab_focus()

func _on_field_mouse_exited() -> void:
	$field.release_focus()

func _on_field_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		reset_field()

func _on_field_focus_exited() -> void:
	if $field.text == "" and required:
		$required.visible = true
	else:
		$required.visible = false

# Helper Functions
func retrieve_field() -> String:
	return $field.text if $field.text != "" else "None"

func reset_field():
	$field.text = ""
	$required.visible = true if required else false
