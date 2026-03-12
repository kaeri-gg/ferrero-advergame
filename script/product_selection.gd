class_name ProductSelection
extends Panel

signal selection_confirmed(selected: Array[TextureButton])

@onready var product_selection: ProductSelection = %ProductSelection
@onready var product_container: GridContainer = %ProductContainer
@onready var selected_item_count: Label = %SelectedItemCount
@onready var notification_label: Label = %NotificationLabel
@onready var start_game_button: Button = %StartGame

@onready var rocher: TextureButton = %Rocher
@onready var rondnoir: TextureButton = %Rondnoir
@onready var raffaelo: TextureButton = %Raffaelo
@onready var kinderini: TextureButton = %Kinderini
@onready var delice: TextureButton = %Delice
@onready var bueno: TextureButton = %Bueno

var chocolate_options: Array[TextureButton]
var selected_chocolates: Array[TextureButton]
var max_chocolate_count: int 
var current_chocolate_count: int

func reset_selection() -> void:
	selected_chocolates = []
	max_chocolate_count = 3
	current_chocolate_count = 0
	notification_label.text = ""

func _ready() -> void:
	reset_selection()
	notification_label.hide()
	
	for child in product_container.get_children():
		if child is TextureButton:
			chocolate_options.append(child)
			unhighlight(child)

	for chocolate in chocolate_options:
		chocolate.button_down.connect(on_button_pressed.bind(chocolate))
		chocolate.mouse_entered.connect(on_hover_start.bind(chocolate))
		chocolate.mouse_exited.connect(on_hover_end.bind(chocolate))
		chocolate.pivot_offset = chocolate.size / 2 # scale from center
	
	start_game_button.pressed.connect(on_start_button_pressed)
		
func on_button_pressed(chocolate: TextureButton) -> void:
	notification_label.hide()
	
	if selected_chocolates.has(chocolate):
		selected_chocolates.erase(chocolate)
		update_choco_counter(-1)
		unhighlight(chocolate)
		return
	
	if selected_chocolates.size() >= max_chocolate_count:
		print("you reached 3")
		return
	
	selected_chocolates.append(chocolate)
	update_choco_counter(1)
	highlight(chocolate)
	print(selected_chocolates)

func update_choco_counter(delta: int) -> void:
	current_chocolate_count += delta
	selected_item_count.text = str(current_chocolate_count, "/3")

func has_selection() -> bool:
	return selected_chocolates.size() > 0

func on_start_button_pressed() -> void:
	if has_selection():
		selection_confirmed.emit(selected_chocolates)
		product_selection.hide()
		
	else:
		notification_label.show()
		notification_label.text = "Please select at least 1 product."
		

func highlight(button: TextureButton) -> void:
	button.modulate = Color(1, 1, 1)

func unhighlight(button: TextureButton) -> void:
	button.modulate = Color("dab9b8ff")

func on_hover_start(button: TextureButton) -> void:
	var tween := create_tween()
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.15).set_ease(Tween.EASE_OUT)

func on_hover_end(button: TextureButton) -> void:
	var tween := create_tween()
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.15).set_ease(Tween.EASE_OUT)
	
