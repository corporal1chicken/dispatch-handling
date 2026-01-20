extends Panel

@export_category("TickBox Field")
@export var title: String = "None Set"
@export var is_checked: bool = false
@export var default_value: bool = false
@export var required: bool = false

var tick_texture = preload("res://assets/icons/tick/white.png")

func _ready():
	$title.text = title
	$tick/TextureRect.visible = is_checked

func _on_button_pressed() -> void:
	is_checked = not is_checked
	$tick/TextureRect.visible = is_checked
	$tick/button.release_focus()

func retrieve_field():
	return is_checked

func reset_field():
	is_checked = default_value
	$tick/TextureRect.visible = is_checked
