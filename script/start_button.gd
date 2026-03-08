class_name StartButton
extends Button

@onready var root := get_tree().get_current_scene()

const game_scene: PackedScene = preload("res://scene/main_scene.tscn")

func on_start_button_pressed() -> void:
	self.text = "Loading..."
	sound_manager.play("EnterGame")
	await utils.timeout(0.5)
	await utils.fade_out(root)
	get_tree().change_scene_to_packed(game_scene)
	
