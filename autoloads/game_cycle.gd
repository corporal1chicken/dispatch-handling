extends Node

var current_shift: String = "shift_001"
var shift_calls: Array = []

var call_timer: Timer

var game_timer: Timer

var total_seconds: int = 0

func _ready():
	randomize()
	
	shift_calls = get_shift_calls()
	
	call_timer = Timer.new()
	add_child(call_timer)
	
	call_timer.autostart = false
	call_timer.one_shot = false
	
	game_timer = Timer.new()
	add_child(game_timer)
	game_timer.autostart = false
	game_timer.one_shot = false
	game_timer.start()
	game_timer.timeout.connect(_on_test_timer_timeout)
	
	_start_call()

func _on_test_timer_timeout():
	total_seconds += 1
	Signals.second_tick.emit(get_timestamp())
	
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
	call_timer.start(Constants.TIME_BETWEEN_CALLS)
	await call_timer.timeout
	
	var path = shift_calls.pick_random()
	shift_calls.erase(path)
	
	Signals.call_recieved.emit(get_file_contents(path))
