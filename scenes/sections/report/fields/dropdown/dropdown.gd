extends ReportField



func _on_expand_pressed() -> void:
	pass # Replace with function body.


func _on_expand_mouse_exited() -> void:
	pass # Replace with function body.

func retrieve_field():
	pass
	
func lock_field():
	field_locked = true
	$expand.disabled = true
	$lock_field.texture_normal = textures.locked
	Signals.field_lock_change.emit("locked")


func _on_lock_field_pressed() -> void:
	if field_locked:
		field_locked = false
		$lock_field.texture_normal = textures.unlocked
		$expand.disabled = false
		Signals.field_lock_change.emit("unlocked")
	else:
		lock_field()
