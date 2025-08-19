class_name CardStateDragging
extends CardState

const FLOATING_ROTATION := 0.0
const FLOATING_Z_INDEX := 1000

var _initial_pos := Vector2.ZERO
var _initial_rotation := 0.0
var _initial_z_index := 0

var _reset_card := true

func _enter_tree() -> void:
	print("%s is now dragging" % _card.name)

	SignalHelper.persist(_interaction.mouse_hold_ended, _on_mouse_hold_ended)

	SignalHelper.persist(CardEvents.card_moved, _on_card_moved)

	_card.scale = Vector2.ONE

	_initial_pos = _card.global_position
	_initial_rotation = _card.global_rotation
	_initial_z_index = _card.z_index

	_card.global_rotation = FLOATING_ROTATION
	_card.z_index = FLOATING_Z_INDEX

	_card.emit_dragged()

func _process(_delta: float) -> void:
	# TODO: show a gap in the card hand where the card would end up after being dropped...
	_card.global_position = get_viewport().get_mouse_position()

func _on_mouse_hold_ended() -> void:
	CardEvents.emit_card_dropped(_card)

	if _reset_card:
		_card.global_position = _initial_pos
		_card.global_rotation = _initial_rotation

	_card.z_index = _initial_z_index

	transition_state(Card.State.INACTIVE)

func _on_card_moved(card: Card) -> void:
	if card == _card:
		_reset_card = false
