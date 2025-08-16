@tool
class_name CardAppearance
extends Node

@export
var card_sprite: Sprite2D

@export
var card_icons: Array[CardIcon] = []

var _card_constants := CardConstants.new()
var _card_sprite_shader: ShaderUpdater = null

func _ready() -> void:
	_card_sprite_shader = ShaderUpdater.new(card_sprite.material as ShaderMaterial)

func refresh(card_data: CardData) -> void:
	if _card_sprite_shader:
		_card_sprite_shader.set_color("border_colour", _card_constants.get_colour(card_data))

	for icon in card_icons:
		icon.card_data = card_data
