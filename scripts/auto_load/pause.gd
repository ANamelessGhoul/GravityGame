extends Node

signal paused()
signal resumed()

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta: float):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	var tree := get_tree()
	tree.paused = not tree.paused
	if tree.paused:
		emit_signal("paused")
	else:
		emit_signal("resumed")
	
