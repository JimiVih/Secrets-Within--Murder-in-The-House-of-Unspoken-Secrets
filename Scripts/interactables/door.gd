extends Node3D

var playerIn: bool = false
@onready var spawnPoint_1: Node3D = $SpawnPoint_1
@onready var spawnPoint_2: Node3D = $SpawnPoint_2
@onready var nextCameraPos_1: Node3D = $cameraPos_1
@onready var nextCameraPos_2: Node3D = $cameraPos_2

func _openDoor(player: Node3D) -> void:
	var playerPosition = player.global_position
	var distanceToPlayer = position.distance_to(playerPosition)
	print(distanceToPlayer)
	print("Door opened")
	var cam: Node3D = $"../Camera3D"
	if spawnPoint_1.global_position.distance_to(playerPosition) <= 1.5:
		player.global_position = spawnPoint_2.global_position
		cam.global_position = nextCameraPos_2.global_position
	elif spawnPoint_2.global_position.distance_to(playerPosition) <= 1.5:
		player.global_position = spawnPoint_1.global_position
		cam.global_position = nextCameraPos_1.global_position
