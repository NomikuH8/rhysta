extends MarginContainer


signal value_changed(sector_name: String, key_name: String, value: Variant)


var sector_name: String = ""
var key_name: String = ""
var default_value: Variant
var dropdown_values: Dictionary = {}


func _ready():
	$MainContainer/HBoxContainer/Label.text = key_name.capitalize()


func _on_check_button_toggled(toggled_on: bool):
	value_changed.emit(sector_name, key_name, toggled_on)
