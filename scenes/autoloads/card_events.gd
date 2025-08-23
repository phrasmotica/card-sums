extends Node

signal card_dragged(card: Card)
signal card_dropped(card: Card)
signal card_moved(card: Card)
signal receptacle_opened
signal receptacle_closed

func emit_card_dragged(card: Card) -> void:
	card_dragged.emit(card)

func emit_card_dropped(card: Card) -> void:
	card_dropped.emit(card)

func emit_card_moved(card: Card) -> void:
	card_moved.emit(card)

func emit_receptacle_opened() -> void:
	receptacle_opened.emit()

func emit_receptacle_closed() -> void:
	receptacle_closed.emit()
