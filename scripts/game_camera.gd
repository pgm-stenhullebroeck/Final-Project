extends Camera2D

var viewport_size

func _ready():
	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x / 2
	
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x

func _process(delta):
	pass

func setup_camera():
	pass

func _physics_process(delta):
	pass
