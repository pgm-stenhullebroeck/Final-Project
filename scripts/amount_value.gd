extends Label

func _ready():
	text = "1"

func _on_h_slider_amount_value_changed(value):
	text = str(value)
