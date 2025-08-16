@tool
class_name Card
extends Node2D

enum State { DISABLED, INACTIVE, HOVERED, DRAGGING }

enum CardIcon { ANKH, ANUBIS, BASTET, COBRA, EYE, HORUS, LOTUS, SCARAB }

@export
var icon := CardIcon.ANKH:
	set(value):
		icon = value

		_refresh()

@export
var colour := Color.WHITE:
	set(value):
		colour = value

		_refresh()

@onready
var appearance: CardAppearance = %Appearance

@onready
var interaction: CardInteraction = %Interaction

var _state_factory := CardStateFactory.new()
var _current_state: CardState = null

signal hovered
signal unhovered

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(Card.State.DISABLED)

func switch_state(state: State, state_data := CardStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		interaction)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CardStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func enable() -> void:
	if _current_state:
		_current_state.enable()

func disable() -> void:
	if _current_state:
		_current_state.disable()

func activate() -> void:
	if _current_state:
		_current_state.activate()

func deactivate() -> void:
	if _current_state:
		_current_state.deactivate()

func emit_hovered() -> void:
	hovered.emit()

func emit_unhovered() -> void:
	unhovered.emit()

func _refresh() -> void:
	if appearance:
		appearance.refresh(icon, colour)
