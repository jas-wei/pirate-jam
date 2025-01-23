extends Node2D


var Room = preload("res://scenes/level/room.tscn")
var Player = preload("res://scenes//player/player.tscn")
var font = preload("res://assets/Fonts/Killer Grandma.ttf")

var tile_size = 16
var num_rooms = 60
var min_size = 5
var max_size = 15
var hspread = 5000
var cull = 0.5

var path
var player = null

var start_room = null
var end_room = null
var shop = null
var loot_rooms = []


var play_mode = false
@onready var Map = $TileMap


func _ready() -> void:
	randomize()
	make_rooms()
	
func make_rooms():
	var positions = []
	for i in range(num_rooms):
		var pos = Vector2(randi_range(-hspread, hspread), 0)
		for spot in positions:
			if (pos.x in range(spot.x - 200, spot.x + 200)) and (pos.y in range(spot.y - 200, spot.y + 200)):
				pos.x += 10000
				pos.y += 10000
		positions.append(pos)
		var r = Room.instantiate()
		var w = (min_size + randi() % (max_size - min_size)) * 2
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)
	# Wait for movement to stop
	await get_tree().create_timer(1.1).timeout
	# Cull rooms
	var room_positions: Array[Vector2] = []
	for room in $Rooms.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.freeze = true
			room.toggle_hitbox()
			room_positions.append(Vector2(room.position.x, room.position.y))
			if room.position.x < 0 and room.position.y > 0:
				start_room = room
			if room.position.x > 0 and room.position.y < 0:
				end_room = room
	await get_tree().process_frame
	# Generate a MST connecting rooms
	path = find_mst(room_positions)
	
	
func _draw():
	if start_room:
		draw_string(font, start_room.position-Vector2(125, 0), "Start")
	if end_room:
		draw_string(font, end_room.position-Vector2(125, 0), "End")
	if play_mode:
		return
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2),
			Color(32, 228, 0), false)
			
	if path:
		for point_id in path.get_point_ids():
			for connected_id in path.get_point_connections(point_id):
				var point_pos = path.get_point_position(point_id)
				var connected_pos = path.get_point_position(connected_id)
				draw_line(
					point_pos,  # Directly use the Vector2 positions
					connected_pos,
					Color(1, 1, 0),  # Yellow color
					15,  # Line width
					true  # Antialiased
				)

			
func _process(delta):
	queue_redraw()
	
func _input(event): 
	if event.is_action("regenerate"):
		if play_mode:
			Player.queue_free()
		for n in $Rooms.get_children():
			n.queue_free()
		path = null
		start_room = null
		end_room = null
		make_rooms()
	if event.is_action("ui_focus_next"):
		make_map()
	if event.is_action_pressed("ui_cancel"):
		player = Player.instantiate()
		add_child(player)
		player.position = start_room.position-Vector2(125, 0)
		
		var current_camera = get_viewport().get_camera_2d()
		if current_camera:
			current_camera.enabled = false
		
		# Create a Camera2D and make it a child of the player
		var player_camera = Camera2D.new()
		player.add_child(player_camera)
		
		player_camera.enabled = true
		player_camera.make_current()
		
		play_mode = true
		
		#var current_camera = get_viewport().get_camera_2d()
		#if current_camera:
			#current_camera.enabled = false
			#
		## Enable player camera
		#
		#var player_camera = player.get_node("Camera2D")
		#if player_camera:
			#player_camera.enabled = true
			#player_camera.make_current()
		#
		#play_mode = true
		
func find_mst(nodes: Array[Vector2]) -> AStar2D:
	var path = AStar2D.new()
	# Add the first node to the AStar2D
	path.add_point(0, nodes.pop_front())  # Use an explicit ID (e.g., 0)

	# Repeat until no more nodes
	while not nodes.is_empty():
		var min_dist = INF  # Minimum distance so far
		var min_p: Vector2 = Vector2.ZERO  # Position of the nearest node
		var p: Vector2 = Vector2.ZERO  # Position of the current point in path

		# Loop through points in the path
		for point_id in path.get_point_ids():
			var p1 = path.get_point_position(point_id)

			# Loop through remaining nodes
			for p2 in nodes:
				var dist = p1.distance_to(p2)
				if dist < min_dist:
					min_dist = dist
					min_p = p2
					p = p1

		# Add the nearest node to the path
		var new_id = path.get_available_point_id()
		path.add_point(new_id, min_p)

		# Connect it to the closest point in the path
		var closest_id = path.get_closest_point(p)
		path.connect_points(closest_id, new_id)

		# Remove the added node from the remaining nodes
		nodes.erase(min_p)
		
	return path
		
func make_map():
	Map.clear()

	var fullRect = Rect2()
	
	# Loop through the rooms and calculate the full area
	for room in $Rooms.get_children():
		var r = Rect2(room.position - room.size, room.get_node("CollisionShape2D").shape.extents * 2)
		fullRect = fullRect.merge(r)

	# Convert the top-left and bottom-right corners from world to map coordinates
	var topLeft = Map.local_to_map(Map.to_local(fullRect.position))
	var bottomRight = Map.local_to_map(Map.to_local(fullRect.end))

	# Set cells in the specified range
	for x in range(topLeft.x, bottomRight.x):
		for y in range(topLeft.y, bottomRight.y):
			Map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 1))
			
	# Carve Rooms
	for room in $Rooms.get_children():
		var corridors = []
		var s = (room.size/tile_size).floor()
		var pos = Map.local_to_map(Map.to_local(room.position))
		var ul = (room.position / tile_size).floor() - s
		for x in range(2, s.x * 2 - 1):
			for y in range(2, s.y * 2 - 1):
				Map.set_cell(0, Vector2i(ul.x + x, ul.y + y), 0, Vector2i(0, 15))
		var p = path.get_closest_point(Vector2(room.position.x, room.position.y))
		for conn in path.get_point_connections(p):
			if conn not in corridors:
				var start = Map.local_to_map(Vector2(path.get_point_position(p).x, path.get_point_position(p).y))
				var end = Map.local_to_map(Vector2(path.get_point_position(conn).x, path.get_point_position(conn).y))
				carve_path(start, end)
		corridors.append(p)
		
func carve_path(pos1, pos2):
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0: x_diff = pow(-1.0, randi() % 2)
	if y_diff == 0: y_diff = pow(-1.0, randi() % 2)
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		Map.set_cell(0, Vector2i(x, x_y.y), 0, Vector2i(0, 15))
		Map.set_cell(0, Vector2i(x, x_y.y + y_diff), 0, Vector2i(0, 15))
		Map.set_cell(0, Vector2i(x, x_y.y + 2 * y_diff), 0, Vector2i(0, 15))
		Map.set_cell(0, Vector2i(x, x_y.y + 3 * y_diff), 0, Vector2i(0, 15))
	for y in range(pos1.y, pos2.y, y_diff):
		Map.set_cell(0, Vector2i(y_x.x, y), 0, Vector2i(0, 15))
		Map.set_cell(0, Vector2i(y_x.x + x_diff, y), 0, Vector2i(0, 15))
		Map.set_cell(0, Vector2i(y_x.x + 2 * x_diff, y), 0, Vector2i(0, 15))
		Map.set_cell(0, Vector2i(y_x.x + 3 * x_diff, y), 0, Vector2i(0, 15))
		

		
