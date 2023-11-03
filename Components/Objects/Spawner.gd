extends Node3D
class_name Spawner

const Z_LIMIT = 20
const Z_SPAWN_VARIATION = 30

enum SPAWN_TYPE {ASTEROID, COIN}

@export var player : Spaceship
@export var spawn_type : SPAWN_TYPE
@export var objects : Array[PackedScene]
@export var speed := 40
@export var max_objects := 100
@export var spawn_range := 60

var object_pool : Array[Area3D]

func _ready():
	set_physics_process(false)

func _physics_process(_delta):
	if spawn_type == SPAWN_TYPE.ASTEROID:
		for obj in object_pool:
			move_obj_forward(obj)
			rotate_obj(obj, SPAWN_TYPE.ASTEROID)
	elif spawn_type == SPAWN_TYPE.COIN:
		for obj in object_pool:
			move_obj_forward(obj)
			rotate_obj(obj, SPAWN_TYPE.COIN)

func _process(_delta):
	position.x = player.position.x
	position.y = player.position.y

# Public methods.
func start():
	set_physics_process(true)
	for obj in object_pool:
		add_child(obj)
		obj.position = new_random_position()
		await get_tree().process_frame

func stop():
	set_physics_process(false)

func restart():
	for obj in object_pool:
		obj.position = new_random_position()

func setup_pool():
	for i in max_objects:
		var new_obj = objects.pick_random().instantiate() as Area3D
		new_obj.top_level = true
		new_obj.add_to_group("props")
		object_pool.push_back(new_obj)

# Private methods.
func new_random_position():
	return Vector3(
		randi_range(-spawn_range, spawn_range),
		randi_range(-spawn_range, spawn_range),
		randi_range(-Z_SPAWN_VARIATION, Z_SPAWN_VARIATION)
		) + position

func is_reached_on_end(obj):
	return obj.position.z >= Z_LIMIT

func move_obj_forward(obj):
	obj.position.z += speed * get_physics_process_delta_time()
	if is_reached_on_end(obj):
		obj.position = new_random_position()

func rotate_obj(obj : Node3D, rotation_mode : SPAWN_TYPE):
	if rotation_mode == SPAWN_TYPE.ASTEROID:
		obj.rotation_degrees.x = obj.position.x + obj.position.z
		obj.rotation_degrees.y = obj.position.y + obj.position.z
		obj.rotation_degrees.z = obj.position.z * 2
	elif rotation_mode == SPAWN_TYPE.COIN:
		obj.rotation_degrees.y = obj.position.y + obj.position.z * 2
