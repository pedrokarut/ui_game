extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for buttn in get_tree().get_nodes_in_group("button"):
		buttn.pressed.connect(aperta.bind(buttn.name))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func aperta(name):
	match name:
		"NewGame":
			get_tree().change_scene_to_file("res://level.tscn")
		"Quit":
			get_tree().quit()
