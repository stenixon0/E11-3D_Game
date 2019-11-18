extends Area

export(String, FILE, "*.tscn") var next_level

func _on_GoalSwitch_body_entered(body):
	if body.name == "Character":
		get_tree().change_scene(next_level)
		
