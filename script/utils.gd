class_name Utils
extends Node

var points = 0

# Async function to add desired delays between execution lines
func timeout(delay: float) -> void:
	var timer := get_tree().create_timer(delay)
	
	await timer.timeout

# It's like CSS transition for any Node to simulate fade in
# Equivalent to { transition: opacity 0.4s; }
func fade_in(node: Node, duration: float = 0.4) -> void:
	# Create Tween instance 
	var tween: Tween = create_tween()
	# Same as CSS opacity(Aplha) but godot named it weirdly :|
	node.modulate.a = 0.0
	node.visible = true
	# Configure animation to set an opacity(Alpha) to 1
	tween.tween_property(node, "modulate:a", 1.0, duration).set_ease(Tween.EASE_OUT)
	# Wait for the animatin to finish before it resolves
	await timeout(duration)
	
func fade_out(node: Node, duration: float = 0.4) -> void:
	# Create Tween instance 
	var tween: Tween = create_tween()
	# Configure animation to set an opacity(Alpha) to 0
	tween.tween_property(node, "modulate:a", 0.0, duration).set_ease(Tween.EASE_IN)
	# Wait for the animatin to finish
	await timeout(duration)
	# And only then mark it as hidden
	node.visible = false

func slide_in(node: Sprite2D, to: float, duration: float = 0.4) -> void:
	# Create Tween instance 
	var tween: Tween = create_tween()
	# Configure animation to change position
	tween.tween_property(node, "position:x", to, duration)
	# Wait for the animatin to finish
	await timeout(duration)
