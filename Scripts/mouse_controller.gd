extends Node

@onready var cam: Camera3D = $"../../Camera3D"
@onready var animationPlayer: AnimationPlayer = $"../AnimationPlayer"
var inspectPos: Node3D
@onready var player: Node3D = $".."
var canShootRay: bool = true
var inspecting: bool = false
var inspectPos_z_Origin: float
var lastTarget

func _ready() -> void:
	inspectPos = cam.get_child(0)
	inspectPos_z_Origin = inspectPos.position.z

func _checkTarget(target: Node3D) -> void:
	var distanceToTarget = player.position.distance_to(target.position)
	var curTarget = target
		#INSPECTABLE
	if distanceToTarget <= 2 and lastTarget != null:
		if target.is_in_group("inspectable") and curTarget == lastTarget:
			inspecting = true
			target._inspectItem()
			canShootRay = false
			lastTarget = null
		elif target.is_in_group("Door") and curTarget == lastTarget:
			target._openDoor(get_parent())
			lastTarget = null
	else:
		if distanceToTarget <= 2 and (target.is_in_group("Door") or target.is_in_group("inspectable")):
			lastTarget = curTarget
		else:
			lastTarget = null
	print(distanceToTarget)
	print(lastTarget)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print(canShootRay)
			if canShootRay:
				_shootRay()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
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
		
