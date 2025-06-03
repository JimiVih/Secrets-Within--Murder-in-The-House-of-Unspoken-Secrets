extends Node

var isDuplicate: bool = false

func _input(event: InputEvent) -> void:
	if isDuplicate:
		pass
		#_NOTE
		#TEE JOKAISELLE PUZZLELLE OMA PUZZLE SCRIPTI, MUTTA KÄYTÄ TÄTÄ POHJANA

func _openPuzzle() -> void:
	var itemDuplicate = duplicate()
	itemDuplicate.isDuplicate = true
