class_name CardReceptacleState
extends Node

signal state_transition_requested(new_state: CardReceptacle.State, state_data: CardReceptacleStateData)

var _card_receptacle: CardReceptacle = null
var _state_data: CardReceptacleStateData = null

func setup(
	card_receptacle: CardReceptacle,
	state_data: CardReceptacleStateData,
) -> void:
	_card_receptacle = card_receptacle
	_state_data = state_data

func transition_state(
	new_state: CardReceptacle.State,
	state_data := CardReceptacleStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("cycle_state_machine"):
		cycle()

func cycle() -> void:
	pass
