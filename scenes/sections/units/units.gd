extends Panel

func _ready():
	Signals.report_sent.connect(_on_report_sent)
	Signals.call_accepted.connect(_on_call_accepted)
	
func _on_call_accepted():
	$requirement/label.text = "REPORT NOT SENT"

func _on_report_sent():
	$requirement.visible = false
