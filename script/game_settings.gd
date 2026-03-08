extends Node

const CONFIG_PATH := "user://display_settings.cfg"

const RESOLUTION_OPTIONS: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440)
]

const UI_SCALE_OPTIONS: Array[float] = [1.0, 1.15, 1.25, 1.35, 1.5]

var resolution: Vector2i = Vector2i(1920, 1080)
var ui_scale: float = 1.15

func _ready() -> void:
	load_settings()
	apply()

func set_resolution(value: Vector2i) -> void:
	resolution = value
	apply()
	save_settings()

func set_ui_scale(value: float) -> void:
	ui_scale = value
	apply()
	save_settings()

func apply() -> void:
	var window := get_window()
	window.content_scale_factor = ui_scale
	
	# Browsers control canvas size, so only apply desktop window size directly.
	if OS.has_feature("web"):
		return
	
	DisplayServer.window_set_size(resolution)
	_center_window()

func _center_window() -> void:
	var screen := DisplayServer.window_get_current_screen()
	var usable_rect := DisplayServer.screen_get_usable_rect(screen)
	var pos := usable_rect.position + (usable_rect.size - resolution) / 2
	DisplayServer.window_set_position(pos)

func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(CONFIG_PATH) != OK:
		return
	
	var width: int = int(cfg.get_value("display", "width", resolution.x))
	var height: int = int(cfg.get_value("display", "height", resolution.y))
	var loaded_scale: float = float(cfg.get_value("display", "ui_scale", ui_scale))
	
	resolution = Vector2i(width, height)
	ui_scale = loaded_scale

func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("display", "width", resolution.x)
	cfg.set_value("display", "height", resolution.y)
	cfg.set_value("display", "ui_scale", ui_scale)
	cfg.save(CONFIG_PATH)
