@tool
class_name CardIcon
extends Sprite2D

@export
var card_data: CardData:
	set(value):
		card_data = value

		SignalHelper.on_changed(card_data, _refresh)

		_refresh()

var _card_constants := CardConstants.new()
var _shader: ShaderUpdater = null

func _ready() -> void:
	_shader = ShaderUpdater.new(material as ShaderMaterial)

	_refresh()

func _refresh() -> void:
	texture = _card_constants.get_icon(card_data)

	if _shader:
		_shader.set_color("icon_colour", _card_constants.get_colour(card_data))
