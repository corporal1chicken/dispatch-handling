extends Control

func _ready():
	Signals.change_screen.connect(_on_change_screen)
	
func _on_change_screen(old_name: String, new_name: String):
	$CanvasLayer.get_node(old_name).visible = false
	$CanvasLayer.get_node(new_name).visible = true
