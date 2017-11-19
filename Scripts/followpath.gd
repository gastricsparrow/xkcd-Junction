extends PathFollow
 
var speed = 0.0
var max_speed = 1.5
var accel = 0.0
var base_accel = 0.04
var decel = -0.8
var midpoint = 0.5
var raycast = null
onready var path_node = get_parent()
onready var spawn_node = path_node.get_parent()
func _ready():
	
	# Raycasting the stoplights
	raycast = RayCast.new()
	raycast.set_type_mask(5)
	raycast.set_rotation(Vector3(90,0,0))
	raycast.set_cast_to(Vector3(0,-0.75,0))
	raycast.translate(Vector3(0,0,0))
	raycast.set_enabled(true)
	raycast.add_exception(self)
	add_child(raycast)
	
	
	
	accel = base_accel
	speed = max_speed
	# checks parent is what Path, locate midpoint to allow crashing
	if path_node.get_name() == "PathS":
		midpoint = 0.48
	elif path_node.get_name() == "PathL":
		midpoint = 0.45
	elif path_node.get_name() == "PathR":
		midpoint = 0.42
	else:
		print("No parent path found.")
		remove_and_skip()
	
	#Checks spawn location
	if spawn_node.get_name() == "SpawnWest":
		raycast.set_layer_mask(1)
	if spawn_node.get_name() == "SpawnNorth":
		raycast.set_layer_mask(2)
	if spawn_node.get_name() == "SpawnEast":
		raycast.set_layer_mask(4)
	if spawn_node.get_name() == "SpawnSouth":
		raycast.set_layer_mask(8)
	
	
	if path_node.get_curve().get_point_count() > 1:
		set_fixed_process(true)



func _fixed_process(delta):
	speed += accel
	
	if speed >= max_speed:
		accel = 0.0
		speed = max_speed
	elif speed < 0:
		speed = 0
	
	
	set_offset(get_offset() + delta * speed)

	# after one run
	if get_unit_offset() >= 1:
		remove_and_skip()
	
	# passed stoplight (Think about moving this to car)
	if get_unit_offset() >= midpoint: # halfway through
			
			speed = max_speed
	
	if raycast.is_colliding():
			if speed > 0.0:
				accel = decel

	else:
		accel = base_accel
		speed = max_speed
	

#func path_draw():
	