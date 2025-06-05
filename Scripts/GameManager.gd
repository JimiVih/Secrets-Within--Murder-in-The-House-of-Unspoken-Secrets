extends Node

var dialogPlayer: AudioStreamPlayer

var hasKey: bool = false
var hasBleach: bool = false
var hasTrophy: bool = false
var hasRing: bool = false
var hasMonocle: bool = false
var knowsBodyOrigin: bool = false

func _dialog(whoIs: String) -> void:
	if whoIs == "Wife":
		pass
	if whoIs == "Husband":
		pass
	if whoIs == "Child":
		pass
