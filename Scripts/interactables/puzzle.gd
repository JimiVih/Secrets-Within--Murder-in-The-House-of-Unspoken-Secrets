extends StaticBody3D

var isDuplicate: bool = false
var mouseDown: bool = false
var itemDuplicate: Node3D
@export var codeInput: String
@export var correctInput: String


func _destroyObject() -> void:
	queue_free()

func _addDigit(digit: String) -> void:
	if !codeInput.is_empty():
		if codeInput.length() < 4:
			codeInput += digit
		if codeInput.length() >= 4:
			if codeInput == correctInput:
				print("code is Correct!")
			else:
				print("wrong code :(")
				codeInput = ""
		else:
			pass
	else:
		codeInput += digit
	print(codeInput)

func _input(event: InputEvent) -> void:
	if isDuplicate:
		if Input.is_action_just_pressed("mouseDown"):
			mouseDown = true
		if Input.is_action_just_released("mouseDown"):
			mouseDown = false
		if Input.is_action_just_pressed("mouseDown_right") and isDuplicate:
			_destroyObject()
func _disableCollision() -> void:
	var coll: CollisionShape3D = $CollisionShape3D
	if isDuplicate:
		coll.disabled = true
	else:
		pass

func _inspectItem(cam: Node3D) -> void:
	#var item = load(instantiatePath)
	itemDuplicate = duplicate()
	cam.get_child(0).add_child(itemDuplicate)
	print(itemDuplicate)
	itemDuplicate.global_position = cam.get_child(0).global_position
	itemDuplicate.isDuplicate = true
	itemDuplicate._disableCollision()

func _openPuzzle() -> void:
	var itemDuplicate = duplicate()
	itemDuplicate.isDuplicate = true
