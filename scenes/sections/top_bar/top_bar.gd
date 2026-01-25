extends Panel

@onready var status: RichTextLabel = $status

var statuses: Dictionary = {
	active = {
		text = "[!] ACTIVE INCIDENT",
		hex = "f90032" # Red
	},
	none = {
		text = "[✓] NO INCIDENT",
		hex = "00ea48", # Green
	},
	incoming = {
		text = "[-] INCOMING INCIDENT",
		hex = "ff782e" # Orange
	}
}

func _ready():
	Signals.call_recieved.connect(_on_call_recieved)
	Signals.call_accepted.connect(_on_call_accepted)
	Signals.call_finished.connect(_on_call_finished)
	Signals.second_tick.connect(_on_second_tick)

func _on_call_recieved(_call_data):
	var type = statuses.incoming
	status.text = "[color=%s]%s" % [type.hex, type.text]

func _on_call_accepted():
	var type = statuses.active
	status.text = "[color=%s]%s" % [type.hex, type.text]

func _on_call_finished():
	var type = statuses.none
	status.text = "[color=%s]%s" % [type.hex, type.text]

func _on_second_tick(timestamp: String):
	$time.text = timestamp
