class_name CardData
extends Resource

enum Icon { ANKH, ANUBIS, BASTET, COBRA, EYE, HORUS, LOTUS, SCARAB }

enum Colour { WHITE, BLACK, RED, YELLOW }

@export
var icon := Icon.ANKH:
	set(value):
		icon = value

		emit_changed()

@export
var colour := Colour.WHITE:
	set(value):
		colour = value

		emit_changed()
