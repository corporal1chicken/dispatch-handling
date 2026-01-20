extends Node

const CALL_FOLDER: String = "res://data/calls/"
const TIME_BETWEEN_CALLS: float = 1.0

var current_shift: String = "shift_001"
var shift_calls: Array = []

var call_timer: Timer

func _ready():
	randomize()
	
	shift_calls = get_shift_calls()
	
	call_timer = Timer.new()
	add_child(call_timer)
	
	call_timer.autostart = false
	call_timer.one_shot = false
	
	_start_call()

func get_file_contents(path: String):
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(text)

	return data

func get_shift_calls() -> Array:
	var files: Array = []
	var directory: DirAccess = DirAccess.open(CALL_FOLDER + current_shift)
	
	directory.list_dir_begin()
	var file = directory.get_next()
	
	while file != "":
		files.append(CALL_FOLDER + current_shift + "/" + file)
		file = directory.get_next()
		
	directory.list_dir_end()

	return files

func _start_call():
	call_timer.start(TIME_BETWEEN_CALLS)
	await call_timer.timeout
	
	var path = shift_calls.pick_random()
	shift_calls.erase(path)
	
	Signals.call_recieved.emit(get_file_contents(path))
