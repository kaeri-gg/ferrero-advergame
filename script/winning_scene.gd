extends Panel

@onready var play_again_button: Button = %PlayAgain

@onready var message: Label = %Message
@onready var score_label: Label = %ScoreLabel
@onready var discount_label: Label = %DiscountLabel
@onready var on_your_next_purchase: Label = %OnYourNextPurchase


func _ready() -> void:
	play_again_button.pressed.connect(on_play_again_pressed.bind())
	get_score_message(get_discount())
	
	score_label.text = "Score: " + str(utils.points)
	discount_label.text = str(get_discount()) + "% DISCOUNT"
	print("Your point: ", utils.points, " ", discount_label.text)

func get_score_message(total_points: int) -> void:
	if total_points == 100:
		message.text = "Outstanding! You'll get full discount!"
	elif total_points >= 80:
		message.text = "Amazing work! Your memory is truly on point!"
	elif total_points >= 60:
		message.text = "Impressive! Your memory skills are strong."
	elif total_points >= 40:
		message.text = "Great job! Your memory is getting sharper."
	elif total_points >= 20:
		message.text = "Good start! Keep practicing your chocolate hunt."
	else:
		message.text = "Nice try! Your memory is warming up."
		
func on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")
	
func get_discount() -> int:
	if utils.points >= 1000:
		return 100
	
	return int((utils.points / 1500.0) * 100)
