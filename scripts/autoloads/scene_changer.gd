extends Node


var current_scene: Node = null


func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path: String, variables: Dictionary = {}):
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	call_deferred("_deferred_goto_scene", path, variables)


func _deferred_goto_scene(path: String, variables: Dictionary):
	current_scene.free()
	
	var scene = ResourceLoader.load(path)
	current_scene = scene.instantiate()
	
	for key in variables.keys():
		current_scene[key] = variables[key]
	
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
