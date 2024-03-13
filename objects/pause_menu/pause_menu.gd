extends Panel

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	var connect_err = Pause.connect("paused", self, "_on_paused")
	assert(connect_err == OK, "Could not connect Pause signals")
	connect_err = Pause.connect("resumed", self, "_on_resumed")
	assert(connect_err == OK, "Could not connect Pause signals")

func _on_paused():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_resumed():
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	


func _on_ResumeButton_pressed():
	Pause.set_pause(false)

# TODO: Reload current world instead of whole scene
func _on_Restart_pressed():
	get_tree().reload_current_scene()
	Physics.set_gravity_direction(Vector3.DOWN)
	Pause.set_pause(false)

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/main_menu.tscn")
	Pause.set_pause(false)
