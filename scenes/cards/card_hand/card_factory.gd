class_name CardFactory

const CARD_SCENE := preload("res://scenes/cards/card/card.tscn")

func create(card_data: CardData, name: String) -> Card:
	var new_card := CARD_SCENE.instantiate()
	new_card.card_data = card_data
	new_card.name = name
	return new_card
