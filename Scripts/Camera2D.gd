extends Camera2D

var target = null

func _physics_process(delta):
	if target:
		position = target.position

func set_camera_limits(left: int, right: int, top: int, bottom: int):
	limit_left = left
	limit_right = right
	limit_top = top
	limit_bottom = bottom
	
