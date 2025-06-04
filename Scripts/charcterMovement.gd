extends CharacterBody3D

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@export var speed: float
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var targ: Vector3
var isDoor: bool = false

func _moveTo(targetPosition, _isDoor: bool) -> void:
	agent.target_position = targetPosition
	targ = targetPosition
	isDoor = _isDoor
	
func _process(delta: float) -> void:
	if velocity.z >= 0.2 or velocity.z <= -0.2 or velocity.x >= 0.2 or velocity.x <= -0.2:
		animationPlayer.play("walking_player")
	else:
		animationPlayer.play("Idle_player")
	

func _physics_process(delta: float) -> void:
	look_at(targ)
	rotation.x = 0
	rotation.z = 0
	if !isDoor:
		if position.distance_to(targ) > 0.5:
			var curLoc = global_transform.origin
			var nextLoc = agent.get_next_path_position()
			var vel = (nextLoc - curLoc).normalized() * speed
			velocity = vel
			move_and_slide()
	else:
		if position.distance_to(targ) > 1.2:
			var curLoc = global_transform.origin
			var nextLoc = agent.get_next_path_position()
			var vel = (nextLoc - curLoc).normalized() * speed
			velocity = vel
			move_and_slide()
