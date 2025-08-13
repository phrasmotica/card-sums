@tool
class_name CardAppearance
extends Node

var ICONS := {
	Card.CardIcon.ANKH: preload("res://assets/sprites/ankh.png"),
	Card.CardIcon.ANUBIS: preload("res://assets/sprites/anubis.png"),
	Card.CardIcon.BASTET: preload("res://assets/sprites/bastet.png"),
	Card.CardIcon.COBRA: preload("res://assets/sprites/cobra.png"),
	Card.CardIcon.EYE: preload("res://assets/sprites/eye-of-horus.png"),
	Card.CardIcon.HORUS: preload("res://assets/sprites/horus.png"),
	Card.CardIcon.LOTUS: preload("res://assets/sprites/lotus.png"),
	Card.CardIcon.SCARAB: preload("res://assets/sprites/gold-scarab.png"),
}

@export
var card_icons: Array[Sprite2D] = []

func refresh(icon_value: Card.CardIcon) -> void:
	for icon in card_icons:
		icon.texture = ICONS[icon_value] as Texture2D
