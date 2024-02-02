extends RigidBody2D

@export var speed = 50

var PositionToGo
var moving = false
var movingRight = false
var movingLeft = false

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	$MoveTimer.start()
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
		
	velocity.y += 0.5
		
	velocity = velocity.normalized() * speed
		
	linear_velocity = velocity
		
		#position.x += velocity.x * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_move_timer_timeout():
	$MoveTimer.stop()
	# if (randi_range(1, 100) < 50):
	var newPos = randi_range(40, 200)
	# if (position.x - newPos <= 50):
	if (position.x < newPos):
		movingRight = true
		movingLeft = false
		moving = true
		PositionToGo = newPos
	else:
		movingRight = false
		movingLeft = true
		moving = true
		PositionToGo = newPos
	#else:
		#var newPos = randi_range(10, 50)
		#if (position.x + newPos >= 200):
			#movingRight = false
			#movingLeft = true
			#moving = true
			#PositionToGo = position.x - newPos
		#else:
			#movingRight = true
			#movingLeft = false
			#moving = true
			#PositionToGo = position.x + newPos
