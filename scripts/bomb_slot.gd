extends TextureButton
signal slot_pressed(slot)

@onready var bomb_texture: TextureRect = $BombTexture
@onready var unknown_texture: TextureRect = $UnknownTexture

func _ready() -> void:
	pass

func _pressed() -> void:
	slot_pressed.emit(self)
