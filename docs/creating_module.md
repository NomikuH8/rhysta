# Creating a module - How to


## File Structure

Inside the `res://modules` folder, create a folder with a unique name in
snake_case for your mod.


## Module Options

Sometimes you may need to parametrize something as a setting, like hit
lighting in osu standard for example, so here is how to do it:

You'll need to create a file called "options_config.gd" in the root of your
module (`res://modules/[your_mod]/options_config.gd`). It will hold all the
options and it's possible values. It's not needed to extend something

There's 4 types of options:
- Toggle (for binary options)
- Dropdown (for multiple options)
- Range (for float or integer options)
- Custom (if the others don't suit your needs)

### Toggle

Toggle has only two states, on and off. It's syntax is (vsync example):

```gd
var options_config: Dictionary = {
	"vsync": {                            # option name, it will capitalize later
		"default_value": false,           # default value for the toggle, boolean
		"type": Options.OptionType.TOGGLE # option type has to be toggle, use this enum
	}
}
```

### Dropdown

Dropdown allows you to select one of multiple values. It's syntax is (window_mode example):

```gd
var options_config: Dictionary = {
	"window_mode": {
		"default_value": ProjectSettings.get_setting("display/window/size/mode"),
		"type": Options.OptionType.DROPDOWN,
		"dropdown_values": {
			# this is in the format "name": value
			"windowed": DisplayServer.WINDOW_MODE_WINDOWED,
			"fullscreen": DisplayServer.WINDOW_MODE_FULLSCREEN,
			"exclusive_fullscreen": DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
		}
	}
}
```

### Range

Range (or Slider) lets you choose a value between a minimum and maximum:

```gd
var options_config: Dictionary = {
	"option_name": {
		"default_value": 5.0,
		"type": Options.OptionType.RANGE,
		"slider_min_value": 0.0
		"slider_max_value": 10.0
		"slider_step": 1.0
	}
}
```

### Custom

Custom option, it lets you make basically anything inside the options,
you just have to provide custom_scene with the path of your option:

```gd
var options_config: Dictionary = {
	"option_name": {
		"type": Options.OptionType.CUSTOM,
		"custom_scene": "path/for/my_option.tscn" # path is relative to res://modules/[your_mod]/
	}
}
```

The custom option scene can have some properties that options_menu will
provide to it:
- `type`: type of the option, generally CUSTOM
- `sector_name`: your mod name, it's the sector in the ConfigFile
- `key_name`: your option name, it's the key in the ConfigFile
- `default_value`: default value provided in options_config
- `option_value_changed`: signal that emits (sector_name, key_name, type, value). If you don't have
this signal, you'll have to save and apply the settings from inside your custom scene


## Module Distribution

When your module is finished, it's time to distribute it. Create a repo if you
didn't do it already and publish as a release (in .zip please)

You may open a Github issue in NomikuH8/rhysta for me to test your module,
and put it in the module list 

# doc still under development
