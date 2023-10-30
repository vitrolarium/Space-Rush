extends Node
class_name PlaneMovement

@export_category("Input Names")
@export var negative_x_name : String
@export var positive_x_name : String
@export var negative_y_name : String
@export var positive_y_name : String

@export_category("Settings")
@export var speed : float
@export var enabled := true

@onready var body = get_parent()

func _physics_process(delta):
	if not enabled: return
	
	var direction = Input.get_vector(negative_x_name, positive_x_name, negative_y_name, positive_y_name)
	if get_parent() is CharacterBody3D:
		body.velocity.x = direction.x * speed
		body.velocity.y = direction.y * speed
		body.move_and_slide()
	else:
		body.position.x = direction.x * speed * delta
		body.position.y = direction.y * speed * delta
