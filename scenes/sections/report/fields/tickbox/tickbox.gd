extends ReportField

@export_category("TickBox Field")
@export var is_checked: bool = false

func _ready():
	$title.text = title
	$tick/TextureRect.visible = is_checked
	
	$lock_field.texture_normal = textures.locked if field_locked else textures.unlocked

func _on_button_pressed() -> void:
	is_checked = not is_checked
	$tick/TextureRect.visible = is_checked
	$tick/button.release_focus()

func retrieve_field():
	return is_checked

func reset_field():
	is_checked = default_value
	$tick/TextureRect.visible = is_checked

func _on_lock_field_pressed() -> void:
	if field_locked:
		Signals.field_lock_change.emit("unlocked")
		field_locked = false
		$tick/button.disabled = false
		$lock_field.texture_normal = textures.unlocked
	else:
		lock_field()
	
func lock_field():
	field_locked = true
	$tick/button.disabled = true
	$lock_field.texture_normal = textures.locked
	Signals.field_lock_change.emit("locked")
