extends Control

@onready var settings_panel: Panel = %SettingsModal
@onready var open_settings_button: TextureButton = %OpenSettings
@onready var close_settings_button: TextureButton = %CloseSettings
@onready var resolution_label: Label = %Resolution
@onready var resolution_option_button: OptionButton = %ResolutionOptionButton

@onready var ui_scale_label: Label = %"UIScale"
@onready var ui_scale_option_button: OptionButton = %UIScaleOptionButton

func _ready() -> void:
	settings_panel.hide()
	if not open_settings_button.pressed.is_connected(_on_open_settings_pressed):
		open_settings_button.pressed.connect(_on_open_settings_pressed)
	if not close_settings_button.pressed.is_connected(_on_close_settings_pressed):
		close_settings_button.pressed.connect(_on_close_settings_pressed)
	_setup_resolution_controls()
	_setup_ui_scale_controls()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		_toggle_settings_panel()
		get_viewport().set_input_as_handled()

func _toggle_settings_panel() -> void:
	settings_panel.visible = not settings_panel.visible

func _on_open_settings_pressed() -> void:
	settings_panel.show()

func _on_close_settings_pressed() -> void:
	settings_panel.hide()

func _setup_resolution_controls() -> void:
	resolution_option_button.clear()
	for i in GameSettings.RESOLUTION_OPTIONS.size():
		var res := GameSettings.RESOLUTION_OPTIONS[i]
		resolution_option_button.add_item("%dx%d" % [res.x, res.y], i)
	
	resolution_option_button.select(_find_resolution_index())
	if not resolution_option_button.item_selected.is_connected(_on_resolution_selected):
		resolution_option_button.item_selected.connect(_on_resolution_selected)
	
	if OS.has_feature("web"):
		resolution_option_button.disabled = true
		resolution_label.text = "Resolution (desktop only):"
	else:
		resolution_option_button.disabled = false
		resolution_label.text = "Resolution:"
	
func _setup_ui_scale_controls() -> void:
	ui_scale_option_button.clear()
	for i in GameSettings.UI_SCALE_OPTIONS.size():
		var value := GameSettings.UI_SCALE_OPTIONS[i]
		ui_scale_option_button.add_item("%d%%" % int(round(value * 100.0)), i)
	
	ui_scale_option_button.select(_find_scale_index())
	if not ui_scale_option_button.item_selected.is_connected(_on_scale_selected):
		ui_scale_option_button.item_selected.connect(_on_scale_selected)
	ui_scale_label.text = "UI Scale:"

func _find_resolution_index() -> int:
	for i in GameSettings.RESOLUTION_OPTIONS.size():
		if GameSettings.RESOLUTION_OPTIONS[i] == GameSettings.resolution:
			return i
	return 2

func _find_scale_index() -> int:
	for i in GameSettings.UI_SCALE_OPTIONS.size():
		if is_equal_approx(GameSettings.UI_SCALE_OPTIONS[i], GameSettings.ui_scale):
			return i
	return 1

func _on_resolution_selected(index: int) -> void:
	var selected := GameSettings.RESOLUTION_OPTIONS[index]
	GameSettings.set_resolution(selected)

func _on_scale_selected(index: int) -> void:
	var selected := GameSettings.UI_SCALE_OPTIONS[index]
	GameSettings.set_ui_scale(selected)
