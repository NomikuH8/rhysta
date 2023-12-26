extends Node


#var modules_path = "user://modules"
var modules_path = "res://modules"
var loaded_mods: Array[String] = []


func _ready():
	reload_modules()


func reload_modules():
	if loaded_mods.size() > 0:
		loaded_mods = []
	
	var dir = DirAccess.open(modules_path)
	if dir == null:
		DirAccess.make_dir_absolute(modules_path)
		dir = DirAccess.open(modules_path)
	
	print("Checking for modules in " + ProjectSettings.globalize_path(modules_path))
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			if not file_name.ends_with(".pck") and not file_name.ends_with(".zip"):
				file_name = dir.get_next()
				continue
			
			var success = ProjectSettings.load_resource_pack(file_name)
			if success:
				loaded_mods.push_back(file_name.split(".")[0])
				print("Imported module " + file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
