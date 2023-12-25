extends Node


signal options_open_close(is_open: bool)


var options_openned: bool = false


func _input(event):
	if event.is_action_pressed("open_options"):
		open_or_close_options()


func open_or_close_options():
	options_openned = not options_openned
	options_open_close.emit(options_openned)


func close_options():
	options_openned = false
	options_open_close.emit(options_openned)
