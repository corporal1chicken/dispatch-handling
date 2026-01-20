extends Panel
class_name ReportField

@export var title: String = "None Set"
@export var required: bool = false
@export var field_locked: bool = false
@export var default_value: Variant
@export var key: String = "None Set"

var textures = {
	locked = preload("res://assets/icons/lock/locked_red.png"),
	unlocked = preload("res://assets/icons/lock/unlocked_green.png")
}
