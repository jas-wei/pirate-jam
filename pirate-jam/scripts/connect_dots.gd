extends Control

@onready var line_layer: Node = $line_layer
@onready var vertices = []  # Array of all Area2D nodes
@onready var button
@onready var dots = []

var current_line: Line2D = null  # Reference to the Line2D being drawn
var start_vertex: Area2D = null  # The starting Area2D
var area_entered = false
@onready var area_2d: Area2D = $Area2D

const air_sigil = [["dot2", "dot7"], ["dot2", "dot9"], ["dot4", "dot6"], ["dot7", "dot9"]]
const fire_sigil = [["dot2", "dot7"], ["dot2", "dot9"], ["dot7", "dot9"]]
const water_sigil = [["dot1", "dot3"], ["dot1", "dot8"], ["dot3", "dot8"]]
const earth_sigil = [["dot1", "dot3"], ["dot1", "dot8"], ["dot3", "dot8"], ["dot4", "dot6"]]

func _ready() -> void:
	# Populate the vertices array with all Area2D children
	vertices = get_tree().get_nodes_in_group("vertices")
	button = get_tree().get_nodes_in_group("Button_container")[0].get_child(1)
	print (button)


func _input(event: InputEvent) -> void:
	if button.disabled == true:
		if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
			if compare_edges(dots, air_sigil):
				print("air sigil drawn")
			if compare_edges(dots, fire_sigil):
				print("fire sigil drawn")
			if compare_edges(dots, water_sigil):
				print("water sigil drawn")
			if compare_edges(dots, earth_sigil):
				print("earth sigil drawn")
		
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				# Find the nearest Area2D to the mouse position
				start_vertex = get_nearest_vertex(get_global_mouse_position())
				if start_vertex:
					# Create a new Line2D and set its starting point
					current_line = Line2D.new()
					current_line.add_point(start_vertex.global_position)
					current_line.add_point(get_global_mouse_position())  # Temporary endpoint
					line_layer.add_child(current_line)
			
			elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and current_line:
				# Find the nearest Area2D to the release position
				var end_vertex = get_nearest_vertex(get_global_mouse_position())
				#print("end", end_vertex)
				if end_vertex and end_vertex != start_vertex:
					# Snap the line to the endpoint and finalize
					current_line.set_point_position(1, end_vertex.global_position)
					print("Connected:", start_vertex.name, "to", end_vertex.name)
					dots.append([str(start_vertex.name), str(end_vertex.name)])
					print(dots)

				else:
					# If no valid end vertex, remove the line
					current_line.queue_free()
				current_line = null
				start_vertex = null

func _process(delta: float) -> void:
	if current_line:
		# Update the endpoint of the current line to the mouse position
		current_line.set_point_position(1, get_global_mouse_position())

func get_nearest_vertex(position: Vector2) -> Area2D:
	
	var nearest_vertex: Area2D = null
	var min_distance = INF
	for vertex in vertices:
		#print(vertex.name, "Global Position:", vertex.global_position)
		if vertex and vertex.global_position:  # Ensure the vertex exists
			var distance = position.distance_to(vertex.global_position)
			#print("Distance to", vertex.name, ":", distance)
			if distance < min_distance:
				min_distance = distance
				nearest_vertex = vertex
	#print("Nearest vertex:", nearest_vertex.name if nearest_vertex else "None")
	return nearest_vertex
	
func compare_edges(dots: Array, answer_key: Array) -> bool:
	# Convert each edge in both dots and answer_key to a sorted Array (order doesn't matter)
	for edge in dots:
		edge.sort()
		#print(edge)
	dots.sort()
	#print(dots)

	return dots == answer_key


#func _on_area_2d_mouse_entered() -> void:
	#print("entered")
	#area_entered = true
#
#
#func _on_area_2d_mouse_exited() -> void:
	#area_entered = false
