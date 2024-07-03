extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 7.0
const MOUSE_ROTATION = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_gingando = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if is_on_floor():
		$"robot-early-7"/AnimationTree.set("parameters/do_jump/transition_request", "false")

	if Input.is_action_just_pressed("gingado") and is_on_floor():
		if is_gingando:
			$"robot-early-7/AnimationTree".set("parameters/Blend3/blend_amount", 0.0)
			is_gingando = false
		else:
			$"robot-early-7/AnimationTree".set("parameters/Blend3/blend_amount", -1.0)
			is_gingando = true

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !is_gingando:
		velocity.y = JUMP_VELOCITY
		$"robot-early-7"/AnimationTree.set("parameters/do_jump/transition_request", "true")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif !is_gingando:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if !is_gingando:
		move_and_slide()
		#print("X: " + str(input_dir.x) + ", Z: " + str(input_dir.y))
		if velocity.x != 0 or velocity.z != 0:
			$"robot-early-7/AnimationTree".set("parameters/Blend3/blend_amount", 1.0)
		else:
			$"robot-early-7/AnimationTree".set("parameters/Blend3/blend_amount", 0.0)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		#$Camera3D.rotate_y(-lerp(0.0, MOUSE_ROTATION, event.relative.x / 10))
		rotate_y(-lerp(0.0, MOUSE_ROTATION, event.relative.x / 10))
		pass
