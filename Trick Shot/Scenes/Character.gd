extends KinematicBody


var gravity = Vector3.DOWN * 9
var acceleration = 0.1
var friction = 0.01
var jump_speed = 6
var jump = false
var can_move = true

var velocity = Vector3()

var spin = 0.1

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed

func get_input():
	if !can_move:
		return
	var vy = velocity.y
	jump = false
	if Input.is_action_pressed("move_forward"):
		if !is_on_floor() or $RayCast.is_colliding():
			velocity += -transform.basis.z * acceleration
	elif Input.is_action_pressed("move_back"):
		velocity += transform.basis.z * acceleration
	elif Input.is_action_pressed("strafe_left"):
		velocity += -transform.basis.x * acceleration
	elif Input.is_action_pressed("strafe_right"):
		velocity += transform.basis.x * acceleration
	elif Input.is_action_pressed("jump"):
		jump = true
	else:
		velocity.z = lerp(velocity.z, 0, friction)
		velocity.x = lerp(velocity.x, 0, friction)
	velocity.y = vy

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-lerp(0, spin, event.relative.x/10))

func take_damage():
	velocity *= -1
	velocity.y = jump_speed
	can_move = false
	yield(get_tree().create_timer(1), "timeout")
	can_move= true
	
	
	
	
