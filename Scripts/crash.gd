extends RigidBody

# class member variables go here, for example:
var colliders = []

func _ready():
	
	# Called every time the node is added to the scene.
	# Initialization here
	set_contact_monitor(true)
	set_max_contacts_reported(2)
	add_collision_exception_with(self)
	
	connect("body_enter", self, "_on_car_body_enter")
	
func _on_car_body_enter(body):
	print ("in")
	if body.get_name() == "Hit":
			# get_tree().set_pause(true)
		print ("Ouch")
	elif body.get_name().contains("StopLight"):
		print ("Beep Beep")
