extends Node


enum OptionType {
	RANGE,
	DROPDOWN,
	TOGGLE,
	CUSTOM
}


var modules_path = "res://modules/"
var options_config_name = "/options_config.json"
var config_path = "user://rhysta_config.cfg"

var config: Dictionary = {
	"rhysta": {
		"window_mode": ProjectSettings.get_setting("display/window/size/mode"),
		"vsync": false
	}
}

var options_config: Array[Dictionary] = [
	{
		"name": "rhysta",
		"options": {
			"window_mode": {
				"default_value": ProjectSettings.get_setting("display/window/size/mode"),
				"type": OptionType.DROPDOWN,
				"dropdown_values": {
					"windowed": Window.MODE_WINDOWED,
					"fullscreen": Window.MODE_FULLSCREEN,
					"exclusive_fullscreen": Window.MODE_EXCLUSIVE_FULLSCREEN
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
	var globalized_path = ProjectSettings.globalize_path(config_path)
	var file = FileAccess.open(globalized_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(config, "  "))
	file.close()


func load_config():
	var globalized_path = ProjectSettings.globalize_path(config_path)
	var file = FileAccess.open(globalized_path, FileAccess.READ)
	if file == null:
		save_config()
		file = FileAccess.open(globalized_path, FileAccess.READ)
	
	var content = file.get_as_text()
	config = JSON.parse_string(content)
	file.close()
	
	apply_rhysta_config()


func apply_rhysta_config():
	var options = config["rhysta"]
	if options["vsync"]:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	if not options["vsync"]:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func load_options():
	for mod in ModManager.loaded_mods:
		# if the mod is something like osu_standard,
		# the options_config file will be something like:
		# res://modules/osu_standard/options_config.json
		var mod_options_config_file = FileAccess.open(
			modules_path + mod + options_config_name,
			FileAccess.READ
		)
		
		var mod_options = {
			"name": mod,
			"options": JSON.parse_string(mod_options_config_file.get_as_text())
		}
		options_config.push_back(mod_options)
