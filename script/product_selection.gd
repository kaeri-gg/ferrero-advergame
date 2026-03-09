class_name ProductSelection
extends Panel

@onready var product_selection: ProductSelection = %ProductSelection
@onready var product_container: GridContainer = %ProductContainer

@onready var product_1: TextureButton = %Product1 # ferrero rocker
@onready var product_2: TextureButton = %Product2 # rondnoir
@onready var product_3: TextureButton = %Product3 # raffaelo
@onready var product_4: TextureButton = %Product4 # kinderini
@onready var product_5: TextureButton = %Product5 # delice
@onready var product_6: TextureButton = %Product6 # bueno

var chocolate_options: Array[Button]

func _ready() -> void:
	for child in product_container.get_children():
		if child is Button:
			chocolate_options.append(child)
		
	for i in chocolate_options.size():
		chocolate_options[i].button_down.connect(on_button_pressed.bind(i))

func on_button_pressed(index: int) -> void:
	# pass string to identify the product selected and then use it as a reference to pickup which asset to use.
	pass
