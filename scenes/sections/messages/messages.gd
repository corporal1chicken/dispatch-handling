extends Panel

@onready var template_label: RichTextLabel = $template_label
@onready var call_holder: Control = $holders/caller/Control
@onready var timer: Timer = $Timer

const TIME_BETWEEN_MESSAGE: float = 1.0
const SPACING_BETWEEN_MESSAGE: float = 58.0
const TYPEWRITE_EFFECT_SPEED: float = 0.02

var current_call_data: Dictionary

func _ready():
	Signals.call_accepted.connect(_on_call_accepted)
	Signals.call_recieved.connect(_on_call_started)
	
func _hide_call_labels():
	for label in call_holder.get_children():
		label.visible = false

func _create_call(call_data):
	var current_y: float = 0.0
	
	_hide_call_labels()

	for index in call_data.transcript.size():
		var existing_label = call_holder.get_node_or_null(str(index))
		var info = call_data.transcript[index]
		
		if existing_label != null:
			existing_label.text = "[color=red][%s]: [color=white]%s" % [info.user, info.message]
		else:
			var new_label: RichTextLabel = template_label.duplicate()
			
			call_holder.add_child(new_label)
			new_label.text = "[color=red][%s]: [color=white]%s" % [info.user, info.message]
			new_label.name = str(index)
			
			new_label.position = Vector2(30, current_y)
			current_y += SPACING_BETWEEN_MESSAGE
			
	call_holder.custom_minimum_size.y = SPACING_BETWEEN_MESSAGE * call_data.transcript.size()

func _typewrite_effect(label: RichTextLabel):
	label.visible_characters = 0
	label.visible = true
	
	var total_characters: int = label.get_total_character_count()
	
	for character in total_characters:
		label.visible_characters = character + 1
		await get_tree().create_timer(TYPEWRITE_EFFECT_SPEED).timeout

func _on_call_started(call_data: Dictionary):
	current_call_data = call_data
	_create_call(call_data)

func _on_call_accepted():
	for label in call_holder.get_children():
		var info = current_call_data.transcript[int(label.name)]

		await _typewrite_effect(label)
		timer.start(info.wait_time if info.has("wait_time") else TIME_BETWEEN_MESSAGE)
		await timer.timeout
	
	Signals.call_finished.emit()
	_hide_call_labels()
