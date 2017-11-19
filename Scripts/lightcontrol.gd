extends StaticBody

# class member variables go here, for example:
var action = null
onready var light = get_node("SpotLight")
onready var stop_wall = get_node("CollisionShape")
var mode = null
var old_mask = null
const green = Color(0.23, 1, 0.34)
const red = Color(1, 0.25, 0.25)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if get_name() == "StopLight":
		action = "ui_left"
	elif get_name() == "StopLight1":
		action = "ui_up"
	elif get_name() == "StopLight2":
		action = "ui_right"
	elif get_name() == "StopLight3":
		action = "ui_down"
	
	mode = "green"
	old_mask = get_layer_mask()
	set_layer_mask(0)
	light.set_color(0, green)
	set_process_input(true)


func _input(event):
	if event.is_action_released(action):
		if mode == "green":
			mode = "red"
			light.set_color(0, red)
			# activate collision
			set_layer_mask(old_mask)
		elif mode == "red":
			mode = "green"
			light.set_color(0, green)
			# deactivate collision
			set_layer_mask(0)
		pass