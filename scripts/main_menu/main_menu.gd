extends Control
var game_scene: PackedScene = preload("res://scenes/post_process.tscn")

func _on_Play_pressed():
	get_tree().change_scene_to(game_scene)


func _on_Quit_pressed():
	get_tree().quit(0)
