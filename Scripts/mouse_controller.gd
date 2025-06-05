extends Node

@onready var gameManager: Node = $"../../GameManager"
@onready var cam: Camera3D = $"../../Camera3D"
@onready var animationPlayer: AnimationPlayer = $"../AnimationPlayer"
@onready var audioStream2D: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
var inspectPos: Node3D
@onready var player: Node3D = $".."
var canShootRay: bool = true
var inspecting: bool = false
var inspectPos_z_Origin: float
var lastTarget
var curTarget

func _ready() -> void:
	inspectPos = cam.get_child(0)
	inspectPos_z_Origin = inspectPos.position.z

func _checkTarget(target: Node3D) -> void:
	var distanceToTarget = player.position.distance_to(target.position)
	curTarget = target
		#INSPECTABLE
	if lastTarget != null:
		if (target.is_in_group("inspectable") or target.is_in_group("Puzzle")) and curTarget == lastTarget:
			if target.is_in_group("Trophy"):
				if gameManager.hasKey:
					gameManager.hasTrophy = true
					inspecting = true
					target._inspectItem(cam)
					canShootRay = false
					lastTarget = null
					audioStream2D.stream = load("res://Audios/Dialog/Trophy.mp3")
					audioStream2D.play()
					print("Yes Key!")
					return
				else:
					print("No Key")
					return
			if target.is_in_group("Ring"):
				gameManager.hasRing = true
				if gameManager.hasTrophy:
					inspecting = true
					target._inspectItem(cam)
					canShootRay = false
					lastTarget = null
					audioStream2D.stream = load("res://Audios/Dialog/foundRingandtrophy.mp3")
					audioStream2D.play()
					return
				else:
					inspecting = true
					target._inspectItem(cam)
					canShootRay = false
					lastTarget = null
					audioStream2D.stream = load("res://Audios/Dialog/foundRingNoTrophy.mp3")
					audioStream2D.play()
					return
			inspecting = true
			target._inspectItem(cam)
			canShootRay = false
			lastTarget = null
			print("Hello :DDDD")
		elif target.is_in_group("Door") and curTarget == lastTarget and distanceToTarget <= 2:
			target._openDoor(get_parent())
			lastTarget = null
		elif target.is_in_group("Stairs") and curTarget == lastTarget:
			target._openDoor(get_parent())
			lastTarget = null
		elif target.is_in_group("Npc") and curTarget == lastTarget:
			target._speak()
			lastTarget = null
		else:
			lastTarget = null
	else:
		if (target.is_in_group("Door") or target.is_in_group("inspectable") or target.is_in_group("Puzzle")):
			lastTarget = curTarget
			if target.is_in_group("Door"):
				audioStream2D.stream = load("res://Audios/Dialog/clickingDoor.wav")
				audioStream2D.play()
		elif target.is_in_group("Stairs"):
			lastTarget = curTarget
			audioStream2D.stream = load("res://Audios/Dialog/WalkingStairs_sfx_2.wav")
			audioStream2D.play()
		elif target.is_in_group("Npc") and distanceToTarget <= 2:
			lastTarget = curTarget
		else:
			lastTarget = null
	print(distanceToTarget)
	print(lastTarget)
	print(curTarget)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print(canShootRay)
			if canShootRay:
				_shootRay()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			if gameManager.hasKey and curTarget.name == "numbPad":
				audioStream2D.stream = load("res://Audios/Dialog/Getkey.mp3")
				audioStream2D.play()
			if !canShootRay:
				canShootRay = true
				if inspecting:
					inspectPos.position.z = inspectPos_z_Origin

func _shootRay():
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 1000
	var from = cam.project_ray_origin(mousePos)
	var to = from + cam.project_ray_normal(mousePos) * rayLength
	var space = cam.get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = from
	rayQuery.to = to
	var raycastResult = space.intersect_ray(rayQuery)
	print(raycastResult)
	if !raycastResult.is_empty():
		#mouseBall.position = raycastResult["position"]
		var targetPos = raycastResult["position"]
		var isDoor: bool
		var curTarget = raycastResult["collider"]
		_checkTarget(curTarget)
		if curTarget.is_in_group("Door"):
			isDoor = true
		else:
			isDoor = false
		if !curTarget.is_in_group("Wall"):
			player._moveTo(targetPos, isDoor)
		else:
			print("This is a WALL-e")
		
