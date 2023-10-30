extends Camera3D
class_name CameraFollower

@export_category("Settings")
@export var weight := 0.1
@export var enabled := true

@onready var body = get_parent() as Node3D
@onready var current_cam_pos = position 

func _process(_delta):
	if not enabled: return
	position = position.lerp(body.position + current_cam_pos, weight)
