class_name CardReceptacleStateData

var _card: Card = null

static func build() -> CardReceptacleStateData:
	return CardReceptacleStateData.new()

func with_card(card: Card) -> CardReceptacleStateData:
	_card = card
	return self

func get_card() -> Card:
	return _card
