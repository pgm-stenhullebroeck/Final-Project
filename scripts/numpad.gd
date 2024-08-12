extends GridContainer

@onready var answer_input = $"../MarginContainer/ExerciseContainer/HBoxContainer/InputBox/AnswerInput"
@onready var numpad_container = $"."

func input(value):
	answer_input.text += str(value)

func _on_numpad_button_pressed():
	input(1)

func _on_numpad_button_2_pressed():
	input(2)

func _on_numpad_button_3_pressed():
	input(3)

func _on_numpad_button_4_pressed():
	input(4)

func _on_numpad_button_5_pressed():
	input(5)

func _on_numpad_button_6_pressed():
	input(6)

func _on_numpad_button_7_pressed():
	input(7)

func _on_numpad_button_8_pressed():
	input(8)

func _on_numpad_button_9_pressed():
	input(9)

func _on_numpad_button_10_pressed():
	answer_input.text = ""

func _on_numpad_button_11_pressed():
	input(0)
