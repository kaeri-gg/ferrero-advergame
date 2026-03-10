class_name MainScene
extends Control

@onready var product_selection: ProductSelection = %ProductSelection

@onready var chocolate_container: GridContainer = %GridContainer
@onready var feedback: Feedback = %Feedback
@onready var player_score_label: Label = %PlayerScoreLabel
@onready var player_timer_label: Label = %PlayerTimerLabel

const WinningScene := preload("res://script/winning_scene.gd")

const feedback_showtime: float = 0.8

var buttons: Array[Button]
var chocolate_count: int
var streak_count: int 
var click_count: int 

var points: int
var seconds: int
var countdown: int

var correct_tiles: Dictionary[int, bool] = {} # Tile index -> Clicked flag
var tiles_icon: Dictionary = {}


var icon_textures = [
	#preload("uid://b6qvf7a0mcdus"),
	#preload("uid://60vxsf5p18ch"),
	#preload("uid://cqf8op828e4ec"),
	#preload("uid://cbao1235bvclv"),
	#preload("uid://cy2luwjnwvnp4"),
	#preload("uid://cbhqqs3dnly3j"),
	#preload("uid://evlaxqmmummb"),
	#preload("uid://o2ymlyqoi65p"),
	#preload("uid://b828o58sc06lq")
]

func reset_game() -> void:
	countdown = 3
	seconds = 60
	chocolate_count = 3
	streak_count = 1
	points = 0
	count_down_label.text = str(countdown)
	player_score_label.text = ""
	player_timer_label.text = ""
	

func reset_round() -> void:
	click_count = 0
	tiles_icon = {}
	assign_icons()
	enable_buttons()
	
func reset_grid() -> void:
	for index in buttons.size():
		buttons[index].icon = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in chocolate_container.get_children():
		if child is Button:
			buttons.append(child)
		
	for i in buttons.size():
		buttons[i].button_down.connect(on_button_pressed.bind(i))
	
	product_selection.show()
	product_selection.selection_confirmed.connect(start_game)

func start_game(selected: Array[TextureButton]) -> void:
	for item in selected:
		icon_textures.append(item)
		
	reset_game()
	chocolate_container.hide()
	start_countdown()

func get_icon_indexes() -> Dictionary[int, bool]:
	var indexes_of_icons: Dictionary[int, bool] = {}
	
	while indexes_of_icons.size() < chocolate_count:
		var random_index = randi_range(0, buttons.size() -1)
		indexes_of_icons.set(random_index, false)
		
	return indexes_of_icons

func assign_icons() -> void:
	correct_tiles = get_icon_indexes()
	
	for index in correct_tiles:
		var icon = get_random_icon()
		fade_in(index, icon)
		tiles_icon.set(index, icon)
	
	await utils.timeout(0.5)
	
	for index in correct_tiles:
		fade_out(index)

func on_play_again_pressed() -> void:
	reset_game()

func on_button_pressed(index: int) -> void:
	
	sound_manager.play("Click")
	buttons[index].disabled = true
	
	if not correct_tiles.has(index):
		# wrong click
		
		feedback.show_wrong()
		handle_lose_round()
		disable_buttons()
		
		await utils.timeout(2 * feedback_showtime)
		feedback.hide()
		
		reset_grid()
		reset_round()
	
	else:
		# Correct click
		correct_tiles.set(index, true)
		click_count += 1
		fade_in(index, tiles_icon.get(index))
		
		if click_count == correct_tiles.size():
			# Round win
			
			handle_win_round()
			evaluate_icon_count()
			streak_count += 1
			
			print("streak_count ",  streak_count)
			print("chocolate_count ", chocolate_count)
			feedback.show_correct()
			disable_buttons()
			await utils.timeout(feedback_showtime)
			
			reset_grid()
			reset_round()
			feedback.hide()
			
		
func get_random_icon():
	return icon_textures[randi() % icon_textures.size()].texture_normal
	
func fade_in(index: int, icon: Variant):
	buttons[index].icon = icon
	utils.fade_in(buttons[index], 0.2)
	
	return buttons[index].icon
	
func fade_out(index: int) -> void:
	var clicked = correct_tiles.get(index)
	if not clicked:
		buttons[index].icon = null
	
func enable_buttons() -> void:
	for button in buttons:
		button.disabled = false
		
func disable_buttons() -> void:
	for button in buttons:
		button.disabled = true

func handle_win_round() -> void:
	points += chocolate_count * streak_count
	player_score_label.text = str(points)
	sound_manager.play("CorrectAnswer")

func handle_lose_round() -> void:
	points += click_count 
	player_score_label.text = str(points)
	sound_manager.play("WrongAnswer")
	
func evaluate_icon_count() -> void:
	if streak_count % 3 == 0:
		chocolate_count += 1

func start_timer() -> void:
	player_timer_label.text = str(seconds)
	
	if seconds <= 0:
		# Game ended timer's out
		print("Game ended", points)
		disable_buttons()
		return show_winning_scene()
		
	await utils.timeout(1)
	seconds -= 1
	await start_timer()

@onready var count_down_label: Label = %CountDownLabel

func start_countdown() -> void:
	count_down_label.text = str(countdown)
	print(countdown)
	sound_manager.play("Tick")
	
	if countdown == 0:
		chocolate_container.show()
		sound_manager.stop("Tick")
		
		player_score_label.text = "0"
		count_down_label.hide()
		
		reset_grid()
		reset_round()
		
		start_timer()
		
		return # stops recursive call
		
	await utils.timeout(1)
	countdown -= 1
	await start_countdown()
	
	
func show_winning_scene() -> void:
	utils.points = points + click_count #adds the last correctly clicked icon 
	sound_manager.play("WinningSound")
	get_tree().change_scene_to_file("res://scene/winning_scene.tscn")
	
	
	
