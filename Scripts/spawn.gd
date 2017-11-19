extends Position3D

enum CAR { path, origin, color }
var last_car = CAR
var car_layer_mask = 0
var east_spawn = 0
var west_spawn = 0
var north_spawn = 0
var south_spawn = 0


const carRef = preload("res://Assets/Cars/Car.tscn")
const path_follow_script = preload("res://Scripts/followpath.gd")

var _timer = null

var wait_between_spawns = 0.3

func _ready():
	
	last_car.origin = ""
	
	_timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(wait_between_spawns) # seconds
	_timer.set_one_shot(false) #loop
	_timer.start()
	

	
func _on_Timer_timeout():
	while (spawn_car()==null):
		continue
	randomize()
	wait_between_spawns = rand_range(0.1, 0.9)
	_timer.set_wait_time(wait_between_spawns)


func spawn_car():
	var car = CAR
	
	#Randomize origin
	randomize()
	var index = floor(rand_range(1,5))
	if index == 1:
		car.origin = "West"
		car_layer_mask = 1
	elif index == 2:
		car.origin = "East"
		car_layer_mask = 4
	elif index == 3:
		car.origin = "North"
		car_layer_mask = 2
	elif index == 4:
		car.origin = "South"
		car_layer_mask = 8
	
	#Randomize path
	var index = floor(rand_range(1,4))
	if index == 1:
		car.path = "S"
	elif index == 2:
		car.path = "L"
	elif index == 3:
		car.path = "R"	
	
	# make sure no repeats
	if car.origin != last_car.origin:
		last_car = car
	else:
		return null
	
	#Randomize color
	var index = floor(rand_range(1,7))
	if index == 1:
		car.color = Color(0.5,0.15,0) # red
	elif index == 2:
		car.color = Color(0.1,0.3,0.6) # blue
	elif index == 3:
		car.color = Color(0.2,0.5,0.1) # green
	elif index == 4:
		car.color = Color(0.65,0.5,0.15) # yellow
	elif index == 5:
		car.color = Color(0.6,0.6,0.6) # white
	elif index == 6:
		car.color = Color(0.2,0.2,0.2) # black
	
	#Spawn path
	var spawn_name = "Spawn" + car.origin
	var spawn_node = get_node(spawn_name)
	
	var path_name = "Path" + car.path
	var path_node = spawn_node.get_node(path_name)
	

	var path_follow = PathFollow.new()
	path_follow.set_script(path_follow_script)
	path_node.add_child(path_follow)
	
	
	
	#set color (can change other material parameters here too)
	var carInstance = carRef.instance()

	var material = FixedMaterial.new()
	
	material.set_parameter(FixedMaterial.PARAM_DIFFUSE, car.color)
	carInstance.set_material_override(material)
	carInstance.get_node("Scan").set_layer_mask(car_layer_mask)

	path_follow.add_child(carInstance)
	
	
	
	return false