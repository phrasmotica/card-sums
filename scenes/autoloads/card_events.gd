extends Node

signal card_dropped(card: Card)
signal receptacle_opened
signal receptacle_closed

func emit_card_dropped(card: Card) -> void:
	card_dropped.emit(card)

func emit_receptacle_opened() -> void:
	receptacle_opened.emit()

func emit_receptacle_closed() -> void:
	receptacle_closed.emit()
