extends Label

@onready var h_slider_amount = $"../HSliderAmount"

func _ready():
	text = str(h_slider_amount.value)

func _on_h_slider_amount_value_changed(value):
	text = str(value)
