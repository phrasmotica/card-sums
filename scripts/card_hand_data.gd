class_name CardHandData
extends Resource

@export
var cards: Array[CardData] = []:
	set(value):
		cards = value

		if cards:
			for c in cards:
				SignalHelper.on_changed(c, emit_changed)

		emit_changed()
