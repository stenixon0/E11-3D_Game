extends Area

export(String, FILE, "*.tscn") var next_level

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Character":
			get_tree().change_scene(next_level)