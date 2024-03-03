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
	
