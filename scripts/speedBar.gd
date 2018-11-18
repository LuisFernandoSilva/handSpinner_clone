extends ProgressBar



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_spinner_speed( value ):
	set_value(value * get_max())
