extends Area2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.y < 0):
		queue_free()
	
	var velocity = Vector2.ZERO
	velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta


func _on_body_entered(body):
	if (body.is_in_group("enemies")):
		body.queue_free()
		queue_free()


func bullet_left_screen():
	queue_free()
