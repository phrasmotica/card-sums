@tool
class_name CardHand
extends Node2D

enum State { CLOSED, FANNED, PAUSED }

@export
var card_hand_data: CardHandData:
	set(value):
		card_hand_data = value

		SignalHelper.on_changed(card_hand_data, _refresh)

		_refresh()

@onready
var card_manager: CardManager = %CardManager

var _state_factory := CardHandStateFactory.new()
var _current_state: CardHandState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(CardHand.State.FANNED)

func switch_state(state: State, state_data := CardHandStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		card_manager)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CardHandStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if card_manager:
		card_manager.inject(card_hand_data, self)
