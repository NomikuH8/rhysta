extends MarginContainer


signal value_changed(sector_name: String, key_name: String, type: Options.OptionType, value: Variant)


var sector_name: String = ""
var key_name: String = ""
var type: Options.OptionType
var default_value: Variant
var dropdown_values: Dictionary = {}


func _ready():
	$MainContainer/HBoxContainer/Label.text = key_name.capitalize()
	
	if type == Options.OptionType.TOGGLE:
		var check_button = $MainContainer/HBoxContainer2/CheckButton
		check_button.button_pressed = default_value
	
	if type == Options.OptionType.DROPDOWN:
		var option_button = $MainContainer/HBoxContainer2/OptionButton
		var config_value = Options.config.get_value(sector_name, key_name, default_value)
		for key in dropdown_values.keys():
			option_button.add_item(key.capitalize())
			if dropdown_values[key] == config_value:
				option_button.selected = option_button.item_count - 1


func _on_check_button_toggled(toggled_on: bool):
	value_changed.emit(sector_name, key_name, type, toggled_on)


func _on_option_button_item_selected(index: int):
	value_changed.emit(sector_name, key_name, type, dropdown_values.values()[index])
