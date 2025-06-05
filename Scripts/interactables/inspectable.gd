extends StaticBody3D
#var instantiatePath: String
var isDuplicate: bool = false
var mouseEntered: bool = false
var mouseDown: bool = false
var itemDuplicate: Node3D
var inspectableName: String

func _destroyObject() -> void:
	queue_free()

func _input(event: InputEvent) -> void:
	if isDuplicate:
		if Input.is_action_just_pressed("mouseDown"):
			mouseDown = true
		if Input.is_action_just_released("mouseDown"):
			mouseDown = false
		if Input.is_action_just_pressed("mouseDown_right") and isDuplicate:
			_destroyObject()
		if Input.is_action_just_pressed("zoomIn"):
			var inspectPos: Node3D = get_parent()
			inspectPos.position.z += 0.05
			global_position = inspectPos.global_position
			print(inspectPos.global_position)
		if Input.is_action_just_pressed("zoomOut"):
			var inspectPos: Node3D = get_parent()
			inspectPos.position.z -= 0.05
			global_position = inspectPos.global_position
			print(inspectPos.global_position)
		if event is InputEventMouseMotion and mouseDown and isDuplicate:
			rotate_object_local(Vector3.UP, event.relative.x  * 0.005)
			rotate_object_local(Vector3.LEFT, event.relative.y  * 0.005)
	
func _inspectItem(cam: Node3D) -> void:
	#var item = load(instantiatePath)
	itemDuplicate = duplicate()
	cam.get_child(0).add_child(itemDuplicate)
	print(itemDuplicate)
	itemDuplicate.global_position = cam.get_child(0).global_position
	itemDuplicate.isDuplicate = true

func _mouse_enter() -> void:
	if isDuplicate and !mouseEntered:
		mouseEntered = true
		print("Mouse is inside")
		print(itemDuplicate)
func _mouse_exit() -> void:
	if isDuplicate and mouseEntered:
		mouseEntered = false
		print("Mouse is outside")
