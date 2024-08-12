extends Control

signal continue_exercise()
signal reset_game()
var hard: bool = false

const SLOT = preload("res://scenes/slot.tscn")
const TIC_TAC_TOE = preload("res://scenes/tic_tac_toe.tscn")
@onready var grid_container = $NinePatchRect/GridContainer
@onready var draw_modal = $DrawModal
@onready var result_label = $DrawModal/VBoxContainer/ResultLabel

const O = preload("res://assets/textures/character/o.png")
const X = preload("res://assets/textures/character/x.png")

var turn: int = 0
var player: bool = true
var slots: Array = []

func _ready():
	for slot_count in range(9):
		var slot = SLOT.instantiate()
		grid_container.add_child(slot)
		slots.append(slot)
		slot.slot_pressed.connect(_on_slot_clicked)

func _on_slot_clicked(slot):
	if !slot.texture_rect.texture:
		if player:
			slot.draw_x()
			player = !player
			turn += 1
		else:
			slot.draw_o()
			player = !player
			turn += 1
	
	var result = game_check()
	
	if result:
		game_over(result)

func game_check():
	for type in [X, O]:
		for row in range(3):
			if slots[0 + 3 * row].texture_rect.texture == type and slots[1 + 3 * row].texture_rect.texture == type and slots[2 + 3 * row].texture_rect.texture == type:
				return [str(type), 1+3*row, 2+3*row, 3+3*row]
		for col in range(3):
			if slots[0 + col].texture_rect.texture == type and slots[3 + col].texture_rect.texture == type and slots[6 + col].texture_rect.texture == type:
				return [str(type), 1+col, 4+col, 7+col]
		if slots[0].texture_rect.texture == type and slots[4].texture_rect.texture == type and slots[8].texture_rect.texture == type:
			return [str(type), 1, 5, 9]
		elif slots[2].texture_rect.texture == type and slots[4].texture_rect.texture == type and slots[6].texture_rect.texture == type:
			return [str(type), 3, 5, 7]
	
	var is_draw = true
	for slot in slots:
		if !slot.texture_rect.texture:
			is_draw = false
	
	if is_draw:
		return ["draw", 0, 0, 0]

func game_over(result):
	if result[0] == str(X):
		result_label.text = "player 1 wins"
	elif result[0] == str(O):
		result_label.text = "player 2 wins"
	else:
		result_label.text = "draw"
		
	
	draw_modal.visible = true



func _on_reset_button_pressed():
	reset_game.emit(self, TIC_TAC_TOE)
	get_tree().current_scene.request_ready()


func _on_return_button_pressed():
	continue_exercise.emit()
	get_tree().queue_delete(self)
