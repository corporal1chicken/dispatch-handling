extends Panel

enum Status{AVAILABLE, UNAVAILABLE, EN_ROUTE, ON_SCENE}

@export var title: String = "None Set"
@export var icon: Texture2D
@export var current_status: Status = Status.AVAILABLE

func _ready():
	pass
	
func _on_tags_mouse_entered() -> void:
	$tags/label.visible = true

func _on_tags_mouse_exited() -> void:
	$tags/label.visible = false
