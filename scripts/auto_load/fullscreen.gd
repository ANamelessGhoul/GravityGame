extends Node

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta: float):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
