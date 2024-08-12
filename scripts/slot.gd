extends TextureButton
signal slot_pressed(slot)

@onready var texture_rect = $TextureRect
const X = preload("res://assets/textures/character/x.png")
const O = preload("res://assets/textures/character/o.png")

func _ready():
	pass

func draw_x():
	texture_rect.texture = X

func draw_o():
	texture_rect.texture = O

func _pressed():
	slot_pressed.emit(self)
