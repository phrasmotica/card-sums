extends Node

signal card_dropped(card: Card)

func emit_card_dropped(card: Card) -> void:
	# TODO: create a priority system for capturing a card. By default, a dropped
	# card should be returned to its hand. However if a card is dropped while
	# over a receptacle, the receptacle should capture it with greater priority
	# than the hand...
	card_dropped.emit(card)
