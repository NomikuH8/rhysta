# Creating a module - How to


## File Structure

Inside the res://modules folder, create a folder with a unique name for your mod.
The unique name can't contain any dot (.). This is because rhysta takes the mod name from
the pck or zip file. Prefer pck over zip files.

Example of allowed names:
- osu_standard.pck
- taiko_no_tatsujin.zip
- sound_voltex.pck

Example of not allowed name:
- etterna_v0.41.pck


## Module Options

Sometimes you may need to parametrize something as a setting, like hit
lighting in osu standard for example, so here is how to do it:

You'll need to create a file called "options_config.json". It will hold
all the options and it's possible values.

There's 4 types of options:
- Toggle (for binary options)
- Dropdown (for multiple options)
- Range (for float or integer options)
- Custom (if the others don't suit your needs)

### Toggle

Toggle has only two states, on and off. It's syntax is (vsync example):

```json
"vsync": {
	"default_value": false,
	"type": OptionType.TOGGLE
}
```

# Doc still in development
