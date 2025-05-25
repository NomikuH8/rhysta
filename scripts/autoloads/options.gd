extends Node


enum OptionType {
	TOGGLE,
	DROPDOWN,
	RANGE,
	CUSTOM
}


var modules_path = "res://modules/"
var options_config_name = "/options_config.gd"
var config_path = "res://rhysta_config.cfg"

var rhysta_config_section = "rhysta"
var config = ConfigFile.new()

var options_config: Array[Dictionary] = [
	{
		"display_name": "Rhysta",
		"name": "rhysta",
		"options": {
			"window_mode": {
				"default_value": ProjectSettings.get_setting("display/window/size/mode"),
				"type": OptionType.DROPDOWN,
				"dropdown_values": {
					"windowed": DisplayServer.WINDOW_MODE_WINDOWED,
					"fullscreen": DisplayServer.WINDOW_MODE_FULLSCREEN,
					"exclusive_fullscreen": DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
				}
			},
			"vsync": {
				"default_value": false,
				"type": OptionType.TOGGLE
			}
		}
	}
]


func _ready():
	load_options()
	load_config()


func save_config():
	config.save(config_path)


func load_config():
	var err = config.load(config_path)
	if err != OK:
		push_error(err)
		return
	
	apply_config()


func apply_config():
	apply_rhysta_config()
	# TODO: call mods apply_config method


func apply_rhysta_config():
	if config.get_value(rhysta_config_section, "vsync", false):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	var window_mode = config.get_value(
		rhysta_config_section,
		"window_mode",
		DisplayServer.WINDOW_MODE_WINDOWED
	)
	DisplayServer.window_set_mode(window_mode)


func load_options():
	for mod in ModManager.loaded_mods:
		# if the mod is something like osu_standard,
		# the options_config file will be something like:
		# res://modules/osu_standard/options_config.gd
		var script = load(modules_path + mod["file_name"] + options_config_name).new()
		
		var mod_options = {
			"display_name": mod["config"]["display_name"],
			"name": mod["file_name"],
			"options": script.options_config
		}
		options_config.push_back(mod_options)
