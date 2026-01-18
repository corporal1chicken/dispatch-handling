extends Panel

@onready var status: RichTextLabel = $status

var statuses: Dictionary = {
	active = {
		text = "[!] ACTIVE INCIDENT",
		hex = "ff782e"
	},
	none = {
		text = "[✓] NO INCIDENT",
		hex = "00ea48",
	},
	incoming = {
		text = "[-] INCOMING INCIDENT",
		hex = "f90032"
	}
}

func _ready():
	Signals.call_recieved.connect(_on_call_recieved)
	Signals.call_accepted.connect(_on_call_accepted)
	Signals.call_finished.connect(_on_call_finished)

func _on_call_recieved(_call_data):
	var type = statuses.incoming
	status.text = "[color=%s]%s" % [type.hex, type.text]

func _on_call_accepted():
	var type = statuses.active
	status.text = "[color=%s]%s" % [type.hex, type.text]

func _on_call_finished():
	var type = statuses.none
	status.text = "[color=%s]%s" % [type.hex, type.text]
