extends Node

signal paused()
signal resumed()

var is_paused: bool = false

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta: float):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func set_pause(new_pause: bool):
	var tree := get_tree()
	is_paused = new_pause
	tree.paused = is_paused
	if is_paused:
		emit_signal("paused")
	else:
		emit_signal("resumed")

func toggle_pause():
	set_pause(not is_paused)
