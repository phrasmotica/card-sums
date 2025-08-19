class_name CardPositions
extends Node

func get_destination_index(cards: Array[Card], card: Card) -> int:
	if cards.size() <= 0:
		return 0

	var card_x := card.global_position.x
	var positions := _get_positions(cards)

	if card_x < positions[0].x:
		return 0

	for i in positions.size() - 1:
		print("%d vs [%d, %d]" % [card_x, positions[i].x, positions[i + 1].x])
		if card_x >= positions[i].x and card_x < positions[i + 1].x:
			return i + 1

	return positions.size()

func _get_positions(cards: Array[Card]) -> Array[Vector2]:
	var positions: Array[Vector2] = []

	for c in cards:
		positions.append(c.global_position)

	positions.sort_custom(_sort_by_x)

	return positions

func _sort_by_x(v1: Vector2, v2: Vector2) -> bool:
	return v1.x < v2.x
