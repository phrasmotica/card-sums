class_name CardReceptacle
extends Control

enum State { INACTIVE, WAITING, ACCEPTED }

@onready
var interaction: CardReceptacleInteraction = %Interaction

var _state_factory := CardReceptacleStateFactory.new()
var _current_state: CardReceptacleState = null

func _ready() -> void:
	switch_state(CardReceptacle.State.INACTIVE)

func switch_state(state: State, state_data := CardReceptacleStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		interaction)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CardReceptacleStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)
