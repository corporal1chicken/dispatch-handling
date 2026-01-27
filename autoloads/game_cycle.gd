extends Node

var current_shift: String = "shift_001"
var shift_calls: Array = []

var in_call: bool = false
var time_since_call: int = 0

var game_timer: Timer

var total_seconds: int = 0

func _ready():
	randomize()
	
	shift_calls = get_shift_calls()
	
	game_timer = Timer.new()
	add_child(game_timer)
	game_timer.autostart = false
	game_timer.one_shot = false
	game_timer.timeout.connect(_on_test_timer_timeout)
	
	Signals.shift_started.connect(_on_shift_started)

func _on_test_timer_timeout():
	total_seconds += 1
	time_since_call += 1
	Signals.second_tick.emit(get_timestamp())
	
	if time_since_call >= Constants.TIME_BETWEEN_CALLS and not in_call:
		print(time_since_call)
		_start_call()
		time_since_call = 0
	
func get_timestamp() -> String:
	var current_seconds = total_seconds
	
	return "%02d:%02d:%02d" % [
		(current_seconds / 3600) % 24, 
		(current_seconds / 60) % 60, 
		(current_seconds % 60)
	]

func get_file_contents(path: String):
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(text)

	return data

func get_shift_calls() -> Array:
	var files: Array = []
	var directory: DirAccess = DirAccess.open(Constants.CALL_FOLDER + current_shift)
	
	directory.list_dir_begin()
	var file = directory.get_next()
	
	while file != "":
		files.append(Constants.CALL_FOLDER + current_shift + "/" + file)
		file = directory.get_next()
		
	directory.list_dir_end()

	return files

func _start_call():
	var path = shift_calls.pick_random()
	shift_calls.erase(path)
	
	Signals.call_recieved.emit(get_file_contents(path))
	in_call = true

func _on_shift_started():
	game_timer.start(1.0)
