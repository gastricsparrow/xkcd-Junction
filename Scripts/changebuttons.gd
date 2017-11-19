extends Sprite3D

# class member variables go here, for example:
onready var textures = [load("res://Assets/Sprites/wasd.tex"), load("res://Assets/Sprites/arrows.tex")]


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (Input.is_key_pressed(KEY_W)||Input.is_key_pressed(KEY_S)||Input.is_key_pressed(KEY_A)||Input.is_key_pressed(KEY_D)):
		set_texture(textures[0])
	if (Input.is_key_pressed(KEY_UP)||Input.is_key_pressed(KEY_DOWN)||Input.is_key_pressed(KEY_LEFT)||Input.is_key_pressed(KEY_RIGHT)):
		set_texture(textures[1])