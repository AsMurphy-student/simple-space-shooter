extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

signal hit

var health = 3

@export var playerbullet_scene: PackedScene

var timer

var onCooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	timer = get_node("ShootTimer")

func spawnbullet():
	# Create a new instance of the Mob scene.
	var bullet = playerbullet_scene.instantiate()

	# Set the mob's direction perpendicular to the path direction.
	# var direction = -PI / 2
	
	# var direction = Vector2.DOWN
	
	# Set the mob's position to a random location.
	bullet.position = position

	# Add some randomness to the direction.
	# direction += randf_range(-PI / 4, PI / 4)
	# bullet.rotation = direction

	# Choose the velocity for the mob.
	# var velocity = Vector2(50.0, 0.0)
	# bullet.velocity = velocity.rotated(direction)
	
	bullet.add_to_group("playerbullets")
	
	# Spawn the mob by adding it to the Main scene.
	# add_child(bullet)
	get_node("../PlayerBulletContainer").add_child(bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("fire"):
		if (!onCooldown):
			spawnbullet()
			onCooldown = true
			timer.start()
		
		
		

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	


func _on_body_entered(body): 
	if (body.is_in_group("enemies")):
		body.queue_free()
		if (health > 1):
			health = health - 1
		else:
		
	
			# if (body.name == "test")
			# if (body.is_in_group("group");
			# do stuff for figuring out what is what
	
			hide() # Player disappears after being hit.
			hit.emit()
			# Must be deferred as we can't change physics properties on a physics callback.
			# Disables collision so signal is only sent once
			$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_shoot_timer_timeout():
	onCooldown = false


func on_enemy_bullet_entered(area):
	if (area.is_in_group("enemybullets")):
		area.queue_free()
		if (health > 1):
			health = health - 1
		else:
		
	
			# if (body.name == "test")
			# if (body.is_in_group("group");
			# do stuff for figuring out what is what
	
			hide() # Player disappears after being hit.
			hit.emit()
			# Must be deferred as we can't change physics properties on a physics callback.
			# Disables collision so signal is only sent once
			$CollisionShape2D.set_deferred("disabled", true)

func reset_health():
	health = 3
