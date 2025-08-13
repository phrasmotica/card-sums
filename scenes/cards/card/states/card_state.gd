class_name CardState
extends Node

signal state_transition_requested(new_state: Card.State, state_data: CardStateData)

var _card: Card = null
var _state_data: CardStateData = null

func setup(
	card: Card,
	state_data: CardStateData,
) -> void:
	_card = card
	_state_data = state_data

func transition_state(
	new_state: Card.State,
	state_data := CardStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
