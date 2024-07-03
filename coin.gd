extends Node3D

const ROTATION = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(ROTATION * delta)

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
