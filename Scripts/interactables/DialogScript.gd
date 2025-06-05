extends StaticBody3D
@onready var GameManager = $"../GameManager"
@export var characterName: String
var audioPlay: AudioStreamPlayer3D

func _ready() -> void:
	audioPlay = get_child(0)
	audioPlay.connect("finished", _endGame)

func _endGame():
	if GameManager.finale:
		GameManager._theEnd()
		print("The end")
	else:
		print("Not yet")

func _speak():
	audioPlay.stream = GameManager._getDialog(characterName)
	audioPlay.play()
		
