extends Panel

@onready var play_again_button: Button = %PlayAgain
@onready var play_bonus_button: Button = %PlayBonus

@onready var message: Label = %Message
@onready var score_label: Label = %ScoreLabel
@onready var discount_label: Label = %DiscountLabel
@onready var on_your_next_purchase: Label = %OnYourNextPurchase
@onready var kinder_kid_image: TextureRect = %KinderKid

const KINDER_KID_SAD = preload("uid://cmhcnq42gy5wf")
const KINDER_KID_HAPPY = preload("uid://b1fgqjtt2eh6m")
const KINDER_KID_CYRING = preload("uid://cygdhmkpmsm5")


func _ready() -> void:
	play_again_button.pressed.connect(on_play_again_pressed.bind())
	play_bonus_button.pressed.connect(on_play_bonus_pressed.bind())
	
	get_score_message(get_discount())
	
	score_label.text = "Score: " + str(utils.points)
	discount_label.text = str(get_discount()) + "% DISCOUNT"
	print("Your point: ", utils.points, " ", discount_label.text)

func get_score_message(total_points: int) -> void:
	if total_points == 100:
		message.text = "Outstanding! You'll get full discount!"
		kinder_kid_image.texture = KINDER_KID_HAPPY
		
	elif total_points >= 80:
		message.text = "Amazing work! Your memory is truly on point!"
		kinder_kid_image.texture = KINDER_KID_HAPPY
		
	elif total_points >= 60:
		message.text = "Impressive! Your memory skills are strong."
		kinder_kid_image.texture = KINDER_KID_HAPPY
		
	elif total_points >= 40:
		message.text = "Your memory is getting sharper, keep going!"
		kinder_kid_image.texture = KINDER_KID_HAPPY
		
	elif total_points >= 20:
		message.text = "Not bad! Keep practicing your chocolate hunt!"
		kinder_kid_image.texture = KINDER_KID_SAD
		
	else:
		message.text = "I think you fell asleep. It happens!"
		on_your_next_purchase.text = "You can try again!"
		kinder_kid_image.texture = KINDER_KID_CYRING
		
		
func on_play_again_pressed() -> void:
	sound_manager.play("EnterGame")
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")
	
func on_play_bonus_pressed() -> void:
	pass	
	
func get_discount() -> int:
	if utils.points >= 1000:
		return 100
	
	return int((utils.points / 1500.0) * 100)
