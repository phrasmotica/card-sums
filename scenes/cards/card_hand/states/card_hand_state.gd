class_name CardHandState
extends Node

signal state_transition_requested(new_state: CardHand.State, state_data: CardHandStateData)

var _card_hand: CardHand = null
var _state_data: CardHandStateData = null

func setup(
	card_hand: CardHand,
	state_data: CardHandStateData,
) -> void:
	_card_hand = card_hand
	_state_data = state_data

func transition_state(
	new_state: CardHand.State,
	state_data := CardHandStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
