extends Control


@export var entry_button: PackedScene


@onready var containers: Array[Control] = [
	$CenterContainer/MarginContainer/HBoxContainer/FirstContainer,
	$CenterContainer/MarginContainer/HBoxContainer/SecondContainer,
	$CenterContainer/MarginContainer/HBoxContainer/ThirdContainer
]
var current_container: int = 0


func _ready():
	populate_containers()
	reload_containers()


func populate_containers():
	for mod in ModManager.loaded_mods:
		var button = entry_button.instantiate()
		button.mod = mod
		button.connect("identified_pressed", _on_mod_button_identified_pressed)
		containers[2].add_child(button)


func reload_containers():
	for container in containers:
		container.visible = containers.find(container) == current_container


func _on_play_button_pressed():
	current_container += 1
	reload_containers()


func _on_options_button_pressed():
	GameShortcuts.open_or_close_options()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_singleplayer_button_pressed():
	current_container += 1
	reload_containers()


func _on_back_button_pressed():
	current_container -= 1
	reload_containers()


func _on_mod_button_identified_pressed(mod: Dictionary):
	var module_path = "res://modules/" + mod["file_name"] + "/" + mod["config"]["entry_scene"]
	get_tree().change_scene_to_file(ProjectSettings.globalize_path(module_path))
