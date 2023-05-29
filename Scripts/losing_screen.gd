extends CanvasLayer


func _on_retry_button_pressed():
	print('asdadsff')
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_quit_button_pressed():
	print('quitting game')
	get_tree().quit()
