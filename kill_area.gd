extends Area3D

@export var character : CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("You died.")
	character.position.x = 0
	character.position.y = 0
	character.position.z = 3
