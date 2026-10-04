extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -900.0
const FALL_LIMIT = 650.0

# Reference to your animation node
@onready var animated_sprite: AnimatedSprite2D = $Sprite2D

# spawn point
@onready var spawn_position: Vector2 = global_position

# point light
@onready var player_light: PointLight2D = $PointLight2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# checking for animations
	if not is_on_floor():
		animated_sprite.play("jump")
	elif velocity.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

	# flipping direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# light logic
	if player_light and player_light.texture_scale > 0.4:
		player_light.texture_scale -= 0.06 * delta
		player_light.texture_scale = max(player_light.texture_scale, 0.3)

	move_and_slide()
	
	if global_position.y > FALL_LIMIT:
		respawn()

func respawn() -> void:
	get_tree().call_deferred("reload_current_scene")
	
# light recharge
func charge_light(amount: float) -> void:
	if player_light:
		player_light.texture_scale += amount
		player_light.texture_scale = min(player_light.texture_scale, 2.0)
