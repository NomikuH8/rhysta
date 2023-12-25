extends Control


@export var toggle_option_scene: PackedScene
@export var dropdown_option_scene: PackedScene
@export var range_option_scene: PackedScene


@onready var animation_player = $AnimationPlayer
@onready var backdrop = $Backdrop
@onready var sidebar_container = $PanelContainer/HBoxContainer/ScrollContainer/SidebarContainer
@onready var options_container = $PanelContainer/HBoxContainer/VBoxContainer/ScrollContainer/OptionsContainer


var mouse_over_backdrop: bool = false


func _ready():
	visible = GameShortcuts.options_openned
	backdrop.visible = visible
	GameShortcuts.options_open_close.connect(_on_options_open_close)
	render_options()


func _input(event: InputEvent):
	if not event is InputEventMouseButton:
		return
	
	if event.is_released():
		return
	
	if mouse_over_backdrop:
		GameShortcuts.close_options()


func render_options():
	for option_config in Options.options_config:
		var sector_name = option_config["name"]
		for option_key in option_config["options"].keys():
			var option_name = option_key
			var option = option_config["options"][option_key]
			var value = Options.config.get_value(
				sector_name,
				option_name,
				option["default_value"]
			)
			
			match option["type"]:
				Options.OptionType.TOGGLE:
					var instance = toggle_option_scene.instantiate()
					instance.type = option["type"]
					instance.sector_name = sector_name
					instance.key_name = option_name
					instance.default_value = value
					instance.connect("option_value_changed", _on_option_value_changed)
					options_container.add_child(instance)
					
				Options.OptionType.DROPDOWN:
					var instance = dropdown_option_scene.instantiate()
					instance.type = option["type"]
					instance.sector_name = sector_name
					instance.key_name = option_name
					instance.default_value = value
					instance.dropdown_values = option["dropdown_values"]
					instance.connect("option_value_changed", _on_option_value_changed)
					options_container.add_child(instance)
					
				Options.OptionType.RANGE:
					var instance = range_option_scene.instantiate()
					instance.type = option["type"]
					instance.sector_name = sector_name
					instance.key_name = option_name
					instance.default_value = value
					instance.slider_min_value = option["slider_min_value"]
					instance.slider_max_value = option["slider_max_value"]
					instance.slider_step = ["slider_step"]
					instance.connect("option_value_changed", _on_option_value_changed)
					options_container.add_child(instance)


func _on_option_value_changed(sector_name: String, key_name: String, _type: Options.OptionType, value: Variant):
	Options.config.set_value(sector_name, key_name, value)
	
	Options.save_config()
	Options.apply_config()


func _on_options_open_close(is_open: bool):
	if is_open:
		visible = GameShortcuts.options_openned
		backdrop.visible = visible
		animation_player.play("options_open")
	else:
		animation_player.play_backwards("options_open")
		await animation_player.animation_finished
		visible = GameShortcuts.options_openned
		backdrop.visible = visible


func _on_backdrop_mouse_entered():
	mouse_over_backdrop = true


func _on_backdrop_mouse_exited():
	mouse_over_backdrop = false

