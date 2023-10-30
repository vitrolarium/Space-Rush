extends Node3D
class_name Spawner

enum SPAWN_TYPE {ASTEROID, COIN}

@export var spawn_type : SPAWN_TYPE
@export var speed := 40

var spawn_timer : Timer

func _ready():
	setup_timer()

func setup_timer():
	spawn_timer = Timer.new()
