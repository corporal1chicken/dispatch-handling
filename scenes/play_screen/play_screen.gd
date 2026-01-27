extends Control

func _ready():
	for button in $Panel/VBoxContainer.get_children():
		button.pressed.connect(_on_menu_option_pressed.bind(button))
	
func _on_menu_option_pressed(button: Button):
	match button.name:
		"play":
			Signals.shift_started.emit()
			Signals.change_screen.emit("play_screen", "main_screen")
		"quit":
			get_tree().quit()
