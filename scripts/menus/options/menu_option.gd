extends MarginContainer


signal option_value_changed(sector_name: String, key_name: String, type: Options.OptionType, value: Variant)


var sector_name: String = ""
var key_name: String = ""
var type: Options.OptionType
var default_value: Variant
var dropdown_values: Dictionary = {}
var slider_min_value: int = 0
var slider_max_value: int = 10
var slider_step: float = 1.0


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
	
	if type == Options.OptionType.RANGE:
		var range_slider = $MainContainer/HBoxContainer2/RangeSlider
		range_slider.min_value = slider_min_value
		range_slider.max_value = slider_max_value
		range_slider.step = slider_step
		range_slider.value = Options.config.get_value(sector_name, key_name, default_value)


func _on_check_button_toggled(toggled_on: bool):
	option_value_changed.emit(sector_name, key_name, type, toggled_on)


func _on_option_button_item_selected(index: int):
	option_value_changed.emit(sector_name, key_name, type, dropdown_values.values()[index])


func _on_range_slider_drag_ended(value_changed: bool):
	if value_changed:
		option_value_changed.emit(sector_name, key_name, type, $MainContainer/HBoxContainer2/RangeSlider.value)
