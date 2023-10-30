extends Control
@export var objective_time := 3

func _ready():
	show_objective()

func show_objective():
	get_tree().create_timer(objective_time).timeout.connect(hide_objective)

func hide_objective():
	pass

func update_timer(time_left : float, full_time : float):
	%ObjectiveProgress.ratio = 1 - (time_left / full_time)
	%TimerLabel.text = str(floor(time_left / 60)).pad_zeros(2) + ":" + str(floori(time_left) % 60).pad_zeros(2)#str(round(fmod(time_left, 59)))
