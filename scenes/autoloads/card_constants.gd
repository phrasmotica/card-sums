class_name CardConstants

var ICONS := {
	CardData.Icon.ANKH: preload("res://assets/sprites/ankh.png"),
	CardData.Icon.ANUBIS: preload("res://assets/sprites/anubis.png"),
	CardData.Icon.BASTET: preload("res://assets/sprites/bastet.png"),
	CardData.Icon.COBRA: preload("res://assets/sprites/cobra.png"),
	CardData.Icon.EYE: preload("res://assets/sprites/eye-of-horus.png"),
	CardData.Icon.HORUS: preload("res://assets/sprites/horus.png"),
	CardData.Icon.LOTUS: preload("res://assets/sprites/lotus.png"),
	CardData.Icon.SCARAB: preload("res://assets/sprites/gold-scarab.png"),
}

var COLOURS := {
	CardData.Colour.WHITE: Color.WHITE,
	CardData.Colour.BLACK: Color.BLACK,
	CardData.Colour.RED: Color.RED,
	CardData.Colour.YELLOW: Color.YELLOW,
}

func get_icon(data: CardData) -> Texture2D:
	if not data:
		return null

	if not ICONS.has(data.icon):
		return null

	return ICONS[data.icon] as Texture2D

func get_colour(data: CardData) -> Color:
	if not data:
		return Color.WHITE

	if not COLOURS.has(data.colour):
		return Color.WHITE

	return COLOURS[data.colour]
