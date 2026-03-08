extends Panel

@onready var play_again_button: Button = %PlayAgain
@onready var discount_text: Label = $Text/LabelsContainer/VBoxContainer/Label2
@onready var score_text: Label = $Text/LabelsContainer/VBoxContainer/Label4

func _ready() -> void:
	play_again_button.pressed.connect(on_play_again_pressed.bind())
	score_text.text = "Score: " + str(utils.points)
	discount_text.text = str(get_discount()) + "% DISCOUNT"
	print("Your point: ", utils.points, " ", discount_text.text)

func on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")
	
func get_discount() -> int:
	if utils.points >= 1000:
		return 100
	
	return int((utils.points / 1500.0) * 100)
