extends Button


signal identified_pressed(mod: String)


var mod: Dictionary = {}


func _ready():
	text = mod["config"]["display_name"]


func _pressed():
	identified_pressed.emit(mod)
