extends RigidBody2D

@export var speed = 20
@export var movespeed = 100

var PositionToGo
var moving = false
var movingRight = false
var movingLeft = false

var screen_size

@export var playerbullet_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$MoveTimer.start()
	$ShootTimer.start()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (movingRight):
		if (position.x >= PositionToGo):
			moving = false
			movingRight = false
			$MoveTimer.start()
			return
	else: if (movingLeft):
		if (position.x <= PositionToGo):
			moving = false
			movingLeft = false
			$MoveTimer.start()
			return
	var velocity = Vector2.ZERO
	if (moving):
		if (movingRight):
			velocity.x += 1
		else: if (movingLeft):
			velocity.x -= 1
	if (position.y <= 20):
		velocity.y += 1
		
	velocity = velocity.normalized()
	velocity.y = velocity.y * speed
	velocity.x = velocity.x * movespeed
		
	linear_velocity = velocity
		
	#position.x += velocity.x * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_move_timer_timeout():
	$MoveTimer.stop()
	if (randi_range(1, 100) < 50):
		var newPos = randi_range(70, 150)
		if (position.x - newPos <= 50):
		# if (position.x < newPos):
			movingRight = true
			movingLeft = false
			moving = true
			PositionToGo = position.x + newPos
		else:
			movingRight = false
			movingLeft = true
			moving = true
			PositionToGo = position.x - newPos
	else:
		var newPos = randi_range(10, 50)
		if (position.x + newPos >= 200):
			movingRight = false
			movingLeft = true
			moving = true
			PositionToGo = position.x - newPos
		else:
			movingRight = true
			movingLeft = false
			moving = true
			PositionToGo = position.x + newPos


func _on_shoot_timer_timeout():
	var bullet = playerbullet_scene.instantiate()
	
	bullet.position = position
	
	var velocity = Vector2.ZERO
	velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	linear_velocity = velocity
	
	bullet.add_to_group("enemybullets")
	
	get_node("../EnemyBulletContainer").add_child(bullet)
	
	$ShootTimer.wait_time = randf_range(0.5, 1.5)
