class_name CardReceptacleAppearance
extends Node

@export
var receptacle: CardReceptacle

@export
var label: Label

func for_inactive() -> void:
	if receptacle:
		receptacle.theme_type_variation = "CardReceptacleContainer"

	if label:
		label.text = "?"

func for_waiting() -> void:
	if receptacle:
		receptacle.theme_type_variation = "CardReceptacleContainerWaiting"

	if label:
		label.text = "..."

func for_accepted() -> void:
	if receptacle:
		receptacle.theme_type_variation = "CardReceptacleContainerAccepted"

	if label:
		label.text = "!"
