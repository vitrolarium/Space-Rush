extends Panel

@export var game_file : PackedScene

func _on_button_pressed():
	get_tree().change_scene_to_packed(game_file)
