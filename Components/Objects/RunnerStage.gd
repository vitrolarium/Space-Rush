extends Node3D
class_name RunnerStage

const SPAWNER_GROUP_NAME = "spawners"

signal game_finished
signal gameover

@export var next_stage : PackedScene
@export var spaceship : Spaceship
@export var intro_ui : Control
@export var hud_ui : Control
@export var done_ui : Control
@export var gameover_ui : Control
@export var run_time := 30

var spawners : Array[Spawner]
var runner_timer : Timer
var is_running := false

func _ready():
	create_timer()
	spaceship.disable_movement()
	setup_spawners()

func _physics_process(_delta):
	hud_ui.update_timer(runner_timer.time_left, runner_timer.wait_time)

func on_start_game():
	intro_ui.hide()
	gameover_ui.hide()
	hud_ui.show()
	start_game()


func start_game():
	is_running = true
	runner_timer.start()
	revive_spaceship()
	get_tree().call_group(SPAWNER_GROUP_NAME, "start")

func restart_game():
	revive_spaceship()
	is_running = true
	runner_timer.start()
	get_tree().call_group(SPAWNER_GROUP_NAME, "restart")
	gameover_ui.hide()
	hud_ui.show()

func goto_next_stage():
	get_tree().change_scene_to_packed(next_stage)

func game_over():
	is_running = false
	runner_timer.stop()
	gameover_ui.show()
	hud_ui.hide()
	get_tree().call_group(SPAWNER_GROUP_NAME, "stop")
	emit_signal("gameover")

func on_game_ended():
	spaceship.disable_movement()
	spaceship.finish()
	hud_ui.hide()
	done_ui.show()
	get_tree().call_group(SPAWNER_GROUP_NAME, "stop")
	emit_signal("game_finished")
	

func start_spawners():
	for spawn in spawners:
		spawn.start()

func restart_spawners():
	for spawn in spawners:
		spawn.restart()

func stop_spawners():
	for spawn in spawners:
		spawn.stop()

func revive_spaceship():
	spaceship.revive()
	spaceship.enable_movement()

func create_timer():
	runner_timer = Timer.new()
	runner_timer.wait_time = run_time
	runner_timer.one_shot = true
	runner_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	runner_timer.timeout.connect(on_game_ended)
	add_child(runner_timer)

func setup_spawners():
	for child in get_children():
		if child is Spawner:
			child.setup_pool()
			child.add_to_group(SPAWNER_GROUP_NAME)
