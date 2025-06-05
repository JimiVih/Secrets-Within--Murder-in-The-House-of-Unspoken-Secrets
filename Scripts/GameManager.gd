extends Node

var dialogPlayer: AudioStreamPlayer
var kidProgress: int = 0
var wifeProgress: int = 0
var husbandProgress: int = 0
var progress: int = 0
var hasKey: bool = false
var hasTrophy: bool = false
var hasRing: bool = false
var hasMonocle: bool = false
var finale: bool = false


func _getDialog(whoIs: String):
	if whoIs == "Wife":
		if hasRing or hasTrophy:
			wifeProgress = 1
		if wifeProgress < 1:
			return load("res://Audios/Dialog/WifeProgress0.mp3")
		if hasRing and !hasTrophy:
			return load("res://Audios/Dialog/giveRing.mp3")
		if hasRing and hasTrophy:
			finale = true
			return load("res://Audios/Dialog/caughtYellowhanded.mp3")
	if whoIs == "Husband":
		if hasMonocle:
			husbandProgress = 1
		if husbandProgress < 1:
			return load("res://Audios/Dialog/ILoveTrophies.mp3")
		if hasMonocle:
			return load("res://Audios/Dialog/fiveMonocle.mp3")
	if whoIs == "Kid":
		if kidProgress < 1:
			kidProgress += 1
			return load("res://Audios/Dialog/kidDinosaur.mp3")
		elif kidProgress == 1:
			kidProgress += 1
			return load("res://Audios/Dialog/isUncleButtOK.mp3")
		elif kidProgress == 2:
			kidProgress += 1
			return load("res://Audios/Dialog/haveYouEverhadadream.mp3")
		if kidProgress >= 2:
			kidProgress = 0

func _getItem(itemPicked: String):
	if itemPicked == "Key":
		hasKey = true
		print("Got " + itemPicked)
	elif itemPicked == "Trophy":
		hasTrophy = true
		print("Got " + itemPicked)
	elif itemPicked == "Ring":
		hasRing = true
		print("Got " + itemPicked)
	elif itemPicked == "Monocle":
		hasMonocle = true
		print("Got " + itemPicked)
	else:
		pass
