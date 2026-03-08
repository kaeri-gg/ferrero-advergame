class_name Feedback
extends Panel

@onready var feedbackImage: TextureRect = %TextureRect

const correct_answer = preload("uid://drdxefdp8x2yw")
const wrong_answer = preload("uid://mpyy6tu83tlb")

func _ready() -> void:
	self.hide()

func show_wrong() -> void:
	self.show()
	feedbackImage.texture = wrong_answer
	utils.fade_in(feedbackImage, 0.2)
	
func show_correct() -> void:
	self.show()
	feedbackImage.texture = correct_answer
	utils.fade_in(feedbackImage, 0.2)
	
