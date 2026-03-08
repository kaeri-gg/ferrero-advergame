extends Control

@onready var menu_vbox: VBoxContainer = $Panel/PanelContainer/MarginContainer/VBoxContainer
@onready var start_button_container: MarginContainer = $Panel/PanelContainer/MarginContainer/VBoxContainer/MarginContainer2

func _ready() -> void:
	_build_display_settings_ui()

func _build_display_settings_ui() -> void:
	var settings_box := VBoxContainer.new()
	settings_box.custom_minimum_size = Vector2(0, 80)
	settings_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var heading := Label.new()
	heading.text = "Display Settings"
	heading.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	settings_box.add_child(heading)
	
	var resolution_row := HBoxContainer.new()
	var resolution_label := Label.new()
	var resolution_option := OptionButton.new()
	resolution_label.text = "Resolution:"
	resolution_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	resolution_option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	for i in GameSettings.RESOLUTION_OPTIONS.size():
		var res := GameSettings.RESOLUTION_OPTIONS[i]
		resolution_option.add_item("%dx%d" % [res.x, res.y], i)
	
	resolution_option.select(_find_resolution_index())
	resolution_option.item_selected.connect(_on_resolution_selected)
	
	if OS.has_feature("web"):
		resolution_option.disabled = true
		resolution_label.text = "Resolution (desktop only):"
	
	resolution_row.add_child(resolution_label)
	resolution_row.add_child(resolution_option)
	settings_box.add_child(resolution_row)
	
	var scale_row := HBoxContainer.new()
	var scale_label := Label.new()
	var scale_option := OptionButton.new()
	scale_label.text = "UI Scale:"
	scale_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scale_option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	for i in GameSettings.UI_SCALE_OPTIONS.size():
		var value := GameSettings.UI_SCALE_OPTIONS[i]
		scale_option.add_item("%d%%" % int(round(value * 100.0)), i)
	
	scale_option.select(_find_scale_index())
	scale_option.item_selected.connect(_on_scale_selected)
	
	scale_row.add_child(scale_label)
	scale_row.add_child(scale_option)
	settings_box.add_child(scale_row)
	
	var insert_index := menu_vbox.get_children().find(start_button_container)
	menu_vbox.add_child(settings_box)
	menu_vbox.move_child(settings_box, insert_index)

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
