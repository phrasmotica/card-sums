class_name CardState
extends Node

signal state_transition_requested(new_state: Card.State, state_data: CardStateData)

var _card: Card = null
var _state_data: CardStateData = null
var _interaction: CardInteraction = null

func setup(
	card: Card,
	state_data: CardStateData,
	interaction: CardInteraction,
) -> void:
	_card = card
	_state_data = state_data
	_interaction = interaction

func transition_state(
	new_state: Card.State,
	state_data := CardStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
