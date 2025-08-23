@tool
class_name CardHand
extends Node2D

enum State { CLOSED, FANNED, PAUSED, WAITING }

@export
var card_hand_data: CardHandData:
	set(value):
		card_hand_data = value

		SignalHelper.on_changed(card_hand_data, _refresh)

		_refresh()

@onready
var interaction: CardHandInteraction = %Interaction

@onready
var card_manager: CardManager = %CardManager

@onready
var renderer: CardRenderer = %CardRenderer

@onready
var state_machine_debug: StateMachineDebug = %StateMachineDebug

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
		interaction,
		card_manager,
		renderer)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CardHandStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

	state_machine_debug.update_text(State.find_key(state) as String, state as int)

func _refresh() -> void:
	if _current_state:
		_current_state.refresh_appearance(card_hand_data)
