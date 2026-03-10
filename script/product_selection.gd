class_name ProductSelection
extends Panel

@onready var product_selection: ProductSelection = %ProductSelection
@onready var product_container: GridContainer = %ProductContainer
@onready var selected_item_count: Label = %SelectedItemCount

@onready var rocher: TextureButton = %Rocher
@onready var rondnoir: TextureButton = %Rondnoir
@onready var raffaelo: TextureButton = %Raffaelo
@onready var kinderini: TextureButton = %Kinderini
@onready var delice: TextureButton = %Delice
@onready var bueno: TextureButton = %Bueno

var chocolate_options: Array[TextureButton]
var selected_chocolates: Array[String]
var max_chocolate_count: int 
var current_chocolate_count: int

func reset_selection() -> void:
	selected_chocolates = []
	max_chocolate_count = 3
	current_chocolate_count = 0

func _ready() -> void:
	reset_selection()
	
	for child in product_container.get_children():
		if child is TextureButton:
			chocolate_options.append(child)

	for chocolate in chocolate_options:
		chocolate.button_down.connect(on_button_pressed.bind(chocolate))
		chocolate.mouse_entered.connect(on_hover_start.bind(chocolate))
		chocolate.mouse_exited.connect(on_hover_end.bind(chocolate))
		chocolate.pivot_offset = chocolate.size / 2 # scale from center
		
func on_button_pressed(chocolate: TextureButton) -> void:
	
	if selected_chocolates.has(chocolate.name):
		selected_chocolates.erase(chocolate.name)
		current_chocolate_count -= 1
		update_choco_counter(current_chocolate_count)
		unhighlight(chocolate)
		return
	
	if selected_chocolates.size() >= max_chocolate_count:
		print("you reached 3")
		return
	
	current_chocolate_count += 1
	selected_chocolates.append(chocolate.name)
	update_choco_counter(current_chocolate_count)
	highlight(chocolate)
	print(selected_chocolates)

func update_choco_counter(count: int) -> void:
	selected_item_count.text = str(count, "/3")

func highlight(button: TextureButton) -> void:
	button.modulate = Color(0.715, 0.746, 0.958, 1.0) # light blue tint

func unhighlight(button: TextureButton) -> void:
	button.modulate = Color(1, 1, 1) # reset to default

func on_hover_start(button: TextureButton) -> void:
	var tween := create_tween()
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.15).set_ease(Tween.EASE_OUT)

func on_hover_end(button: TextureButton) -> void:
	var tween := create_tween()
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.15).set_ease(Tween.EASE_OUT)
	
