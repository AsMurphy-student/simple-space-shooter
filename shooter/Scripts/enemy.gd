extends RigidBody2D

@export var speed = 100

var PositionToGo
var moving = false
var movingRight = false
var movingLeft = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MoveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (movingRight):
		if (position.x >= PositionToGo):
			moving = false
			movingRight = false
			$MoveTimer.start()
	else: if (movingLeft):
		if (position.x <= PositionToGo):
			moving = false
			movingLeft = false
			$MoveTimer.start()
	
	if (moving):
		var velocity = Vector2.ZERO
		if (movingRight):
			velocity.x += 1
		else: if (movingLeft):
			velocity.x -= 1
		
		velocity = velocity.normalized() * speed
		
		position.x += velocity.x * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_move_timer_timeout():
	if (randi_range(1, 100) < 50):
		var newPos = randi_range(10, 50)
		if (position.x - newPos <= 0):
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
		if (position.x + newPos >= 320):
			movingRight = false
			movingLeft = true
			moving = true
			PositionToGo = position.x - newPos
		else:
			movingRight = true
			movingLeft = false
			moving = true
			PositionToGo = position.x + newPos
