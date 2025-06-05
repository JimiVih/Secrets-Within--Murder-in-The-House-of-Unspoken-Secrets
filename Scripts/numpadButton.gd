extends StaticBody3D

var mouseIn: bool = false
@export var numpad_number: String

func _buttonPressed() -> void:
	var numpad_ = get_parent()
	numpad_._addDigit(numpad_number)
	

func _input(event: InputEvent) -> void:
	if mouseIn:
		if event is InputEventMouseButton:
			if Input.is_action_just_pressed("mouseDown"):
				_buttonPressed()

func _mouse_enter() -> void:
	mouseIn = true
	print("mouse in")
func _mouse_exit() -> void:
	mouseIn = false
	print("mouse out")
