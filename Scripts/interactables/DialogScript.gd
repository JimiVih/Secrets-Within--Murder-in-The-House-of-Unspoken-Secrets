extends StaticBody3D
@onready var GameManager = $"../GameManager"
@export var characterName: String
var audioPlay: AudioStreamPlayer3D

func _ready() -> void:
	audioPlay = get_child(0)

func _speak():
	audioPlay.stream = GameManager._getDialog(characterName)
	audioPlay.play()
