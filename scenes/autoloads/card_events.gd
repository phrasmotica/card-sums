extends Node

signal card_dropped(card: Card)

func emit_card_dropped(card: Card) -> void:
	card_dropped.emit(card)
