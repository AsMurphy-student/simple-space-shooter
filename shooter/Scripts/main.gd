extends Node

@export var enemy_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$SpawnTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$SpawnTimer.start()


func enemy_timer_finished():
	# Create a new instance of the Mob scene.
	var mob = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $Path/SpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
	# var direction = Vector2.DOWN
	
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	# direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(20.0, 70.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	mob.add_to_group("enemies")
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
