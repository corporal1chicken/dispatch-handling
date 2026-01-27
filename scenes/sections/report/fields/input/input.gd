extends ReportField

@export_category("Input Field")
@export var placeholder_text: String = "None Set"

# Godot Specific Functions
func _ready():
	$title.text = title
	$field.placeholder_text = placeholder_text
	$required.visible = true if required else false
	
	$lock_field.texture_normal = textures.locked if field_locked else textures.unlocked
	
# UI Functions
func _on_field_mouse_entered() -> void:
	$field.grab_focus()

func _on_field_mouse_exited() -> void:
	$field.release_focus()

func _on_field_focus_exited() -> void:
	if $field.text == "" and required:
		$required.visible = true
	else:
		$required.visible = false

func _on_lock_field_pressed():
	if field_locked:
		_unlock_field()
	else:
		lock_field()
	
# Helper Functions
func retrieve_field():
	return $field.text if $field.text != "" else null

func reset_field():
	$field.text = ""

func _unlock_field():
	field_locked = false
	$field.editable = true
	$lock_field.texture_normal = textures.unlocked
	
	if retrieve_field() == null and required:
		pass
	else:
		Signals.field_lock_change.emit("unlocked")

func lock_field():
	field_locked = true
	$field.editable = false
	$lock_field.texture_normal = textures.locked
	
	if retrieve_field() == null and required:
		pass
	else:
		Signals.field_lock_change.emit("locked")
