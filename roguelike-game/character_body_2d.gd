extends CharacterBody2D

# Movement speed
var speed: float = 200

# Constant fall speed
var fall_speed: float = 300

# Reference to AnimatedSprite2D node
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# --- 1. Handle input ---
	if Input.is_action_pressed("ui_left"):  # A
		input_vector.x -= 1
	elif Input.is_action_pressed("ui_right"): # D
		input_vector.x += 1

	if Input.is_action_pressed("ui_up"): # W
		input_vector.y -= 1
	elif Input.is_action_pressed("ui_down"): # S
		input_vector.y += 1

	# Normalize to prevent faster diagonal movement
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	# --- 2. Set velocity ---
	velocity.x = input_vector.x * speed
	velocity.y = input_vector.y * speed + fall_speed * delta

	# --- 3. Handle animation states ---
	if velocity.y > 0 and input_vector == Vector2.ZERO:
		# Falling straight down
		sprite.play("fall")
	elif input_vector.length() > 0:
		# Walking
		sprite.play("walk")
		sprite.flip_h = input_vector.x < 0
	else:
		# Idle
		sprite.play("idle")

	# --- 4. Move the character ---
	move_and_slide()
