extends Panel

@onready var template_label: RichTextLabel = $template_label
@onready var timer: Timer = $Timer

const TIME_BETWEEN_MESSAGE: float = 5.0
const SPACING_BETWEEN_MESSAGE: float = 58.0

var calls: Array = [
	"res://assets/calls/call_001.json",
	"res://assets/calls/call_002.json"
]

func _load_file(path: String) -> Dictionary:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(text)
	
	return data
	
func _clear_holder():
	for child in $holders/caller.get_children():
		child.queue_free()

func _create_call(call_data):
	var current_y: float = -58.0

	_clear_holder()

	for index in call_data.events.size():
		var info = call_data.events[index]
		var label_duplicate: RichTextLabel = template_label.duplicate()
		$holders/caller.add_child(label_duplicate)
		
		label_duplicate.text = "[color=red][%s]: [color=white]%s" % [info.user, info.message]
		label_duplicate.name = str(index)
		
		current_y += SPACING_BETWEEN_MESSAGE
		label_duplicate.position += Vector2(0, current_y)

func _on_caller_pressed() -> void:
	var path = calls.pick_random()
	var call_data = _load_file(path)
	
	_create_call(call_data)
	
	for child in $holders/caller.get_children():
		var info = call_data.events[int(child.name)]

		child.visible = true
		timer.start(info.wait_time if info.has("wait_time") else TIME_BETWEEN_MESSAGE)
		await timer.timeout
