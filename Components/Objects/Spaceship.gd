extends CharacterBody3D
class_name Spaceship

@export var movement : PlaneMovement
@export var rotation_angle := 30
@export var rotation_smooth := 0.2
signal dead

var is_dead := false
var is_finished := false

func _physics_process(_delta):
	rotation_degrees.y = lerp(rotation_degrees.y, -velocity.normalized().x * rotation_angle, rotation_smooth)#-velocity.normalized().x * rotation_angle
	rotation_degrees.x = lerp(rotation_degrees.x, velocity.normalized().y * rotation_angle, rotation_smooth) #velocity.normalized().y * rotation_angle

func explode():
	die()

func collect_coin(value : int):
	if is_finished: return
	print("ganhei ", value, " moedas B)")

func die():
	if is_finished: return
	is_dead = true
	emit_signal("dead")
	disable_movement()

func revive():
	is_dead = false
	is_finished = false
	enable_movement()
	show()

func disable_movement():
	movement.enabled = false

func enable_movement():
	movement.enabled = true

func finish():
	is_finished = true
