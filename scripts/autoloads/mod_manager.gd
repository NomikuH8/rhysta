extends Node


#var modules_path = "user://modules"
var modules_path = "res://modules"
var loaded_mods: Array[String] = []


func _ready():
	reload_modules()


func reload_modules():
	if loaded_mods.size() > 0:
		loaded_mods = []
	
	var globalized_modules_path = ProjectSettings.globalize_path(modules_path)
	
	var dir = DirAccess.open(globalized_modules_path)
	if dir == null:
		DirAccess.make_dir_absolute(globalized_modules_path)
		dir = DirAccess.open(globalized_modules_path)
	
	print("Checking for modules in " + globalized_modules_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			file_name = dir.get_next()
			continue
		
		loaded_mods.push_back(file_name)
		print("Imported module " + file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
