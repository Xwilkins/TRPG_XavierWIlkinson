extends Node2D




func _on_exit_quit_pressed():
	pass # Replace with function body.
	# when quit is pressed the game closes
	get_tree().quit()
	


func _on_play_pressed():
	pass # Replace with function body.
	# When play is presse go to the overworld
	get_tree().change_scene_to_file("res://over_world.tscn")
