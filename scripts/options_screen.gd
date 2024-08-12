extends BaseScreen

@onready var v_box_container = $TypeSelect/ScrollContainer/VBoxContainer
@onready var h_slider_amount = $Sliders/HSliderAmount
@onready var h_slider_interval = $Sliders/HSliderInterval

func clear():
	var checks = v_box_container.get_children()
	
	for check in checks:
		check.button_pressed = false
	
	h_slider_amount.value = 5
	h_slider_interval.value = 5
