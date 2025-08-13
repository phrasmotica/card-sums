class_name CardReceptacleState
extends Node

signal state_transition_requested(new_state: CardReceptacle.State, state_data: CardReceptacleStateData)

var _card_receptacle: CardReceptacle = null
var _state_data: CardReceptacleStateData = null
var _appearance: CardReceptacleAppearance = null
var _interaction: CardReceptacleInteraction = null

func setup(
	card_receptacle: CardReceptacle,
	state_data: CardReceptacleStateData,
	appearance: CardReceptacleAppearance,
	interaction: CardReceptacleInteraction,
) -> void:
	_card_receptacle = card_receptacle
	_state_data = state_data
	_appearance = appearance
	_interaction = interaction

func transition_state(
	new_state: CardReceptacle.State,
	state_data := CardReceptacleStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
