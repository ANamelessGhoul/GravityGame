extends Node

var static_shader: ShaderMaterial = preload("res://materials/static_post_process/post_process.tres")

var duration: float = 0.5
var _time: float = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(delta):
	var weight = _time / duration
	static_shader.set_shader_param("static_amount", weight * weight)
	_time = max(_time - delta, 0)

func show_static():
	_time = duration
