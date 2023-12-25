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

There's 4 types of options:
	- Toggle (for binary options)
	- Dropdown (for multiple options)
	- Range (for float or integer options)
	- Custom (still in development)

# Doc still in development
