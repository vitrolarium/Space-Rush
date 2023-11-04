extends Control
@export var objective_time := 3
@export var objective_fade_time := 2

func _ready():
	show_objective()

func show_objective():
	get_tree().create_timer(objective_time).timeout.connect(hide_objective)

func hide_objective():
	create_tween()\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_EXPO)\
		.tween_property($ObjectivePanel, "position:y", position.y + size.y, objective_fade_time)

func update_timer(time_left : float, full_time : float):
	%ObjectiveProgress.ratio = 1 - (time_left / full_time)
	%TimerLabel.text = str(floor(time_left / 60)).pad_zeros(2) + ":" + str(floori(time_left) % 60).pad_zeros(2)#str(round(fmod(time_left, 59)))
