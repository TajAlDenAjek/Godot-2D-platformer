extends Control



func _on_start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn");


func _on_quit_pressed():
	$BackGround_music.stop();
	get_tree().quit();
