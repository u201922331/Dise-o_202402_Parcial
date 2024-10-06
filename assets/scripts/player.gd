extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = 400.0
@export var PLAYER_ID = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if PLAYER_ID == 0 and Input.is_action_just_pressed("jump P1") and is_on_floor() or \
	PLAYER_ID == 1 and Input.is_action_just_pressed("jump P2") and is_on_floor() or \
	PLAYER_ID == 2 and Input.is_action_just_pressed("jump P3") and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left P1", "right P1")
	if PLAYER_ID == 1:
		direction = Input.get_axis("left P2", "right P2")
	if PLAYER_ID == 2:
		direction = Input.get_axis("left P3", "right P3")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		print(name + " chocó con " + col.get_collider().name)
