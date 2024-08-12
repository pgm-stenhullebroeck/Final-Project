extends Label

@onready var h_slider_interval = $"../HSliderInterval"

func _ready():
	text = str(h_slider_interval.value)

func _on_h_slider_interval_value_changed(value):
	text = str(value)
