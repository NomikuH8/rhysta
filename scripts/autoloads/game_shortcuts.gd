extends Node


signal options_open_close(is_open: bool)


var options_opened: bool = false


func _input(event):
	if event.is_action_pressed("open_options"):
		open_or_close_options()


func open_or_close_options():
	options_opened = not options_opened
	options_open_close.emit(options_opened)


func close_options():
	options_opened = false
	options_open_close.emit(options_opened)
