extends StaticBody3D

var isDuplicate: bool = false
var mouseDown: bool = false
var itemDuplicate: Node3D
@onready var gameManager: Node = $"../../../GameManager"
@onready var audioPlayer: AudioStreamPlayer2D = $"../../../GameManager/AudioStreamPlayer2D"
@export var codeInput: String
@export var correctInput: String


func _destroyObject() -> void:
	queue_free()

func _addDigit(digit: String) -> void:
	audioPlayer.stream = load("res://Audios/Dialog/Beep.mp3")
	audioPlayer.play()
	if !codeInput.is_empty():
		if codeInput.length() < 4:
			codeInput += digit
		if codeInput.length() >= 4:
			if codeInput == correctInput:
				print("code is Correct!")
				gameManager.hasKey = true
				if audioPlayer.playing:
					audioPlayer.stop()
					audioPlayer.stream = load("res://Audios/Dialog/Correct.mp3")
					audioPlayer.play()
				else:
					audioPlayer.stream = load("res://Audios/Dialog/Correct.mp3")
					audioPlayer.play()
			else:
				print("wrong code :(")
				codeInput = ""
				if audioPlayer.playing:
					audioPlayer.stop()
					audioPlayer.stream = load("res://Audios/Dialog/Wrong.mp3")
					audioPlayer.play()
				else:
					audioPlayer.stream = load("res://Audios/Dialog/Wrong.mp3")
					audioPlayer.play()
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
