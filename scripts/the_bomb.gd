extends Control

signal continue_exercise()
signal reset_game()

@onready var grid_container: GridContainer = $NinePatchRect/GridContainer
@onready var result_modal: ColorRect = $ResultModal
@onready var result_label: Label = $ResultModal/VBoxContainer/ResultLabel

const THE_BOMB = preload("res://scenes/the_bomb.tscn")
const BOMB_SLOT = preload("res://scenes/bomb_slot.tscn")

const bomb_amount: int = 4
var player: bool = true
var slots: Array = []
var bomb_locations: Array = []
var bombs_found: int
var player_1_points: int
var player_2_points: int

func _ready():
	bomb_locations = MyUtility.get_random_numbers(0, 15).slice(0, bomb_amount)
	for slot_count in range(16):
		var slot = BOMB_SLOT.instantiate()
		grid_container.add_child(slot)
		slots.append(slot)
		slot.slot_pressed.connect(_on_slot_clicked)
	

func _on_slot_clicked(slot):
	if slot.unknown_texture.visible == true:
		for n in bomb_locations:
			if slot == slots[n]:
				if player:
					player_1_points += 1
				else:
					player_2_points += 1
				slot.bomb_texture.visible = true
				bombs_found += 1
			slot.unknown_texture.visible = false
		player = !player
	if bombs_found == bomb_amount:
		game_over()

func game_over():
	if player_1_points == player_2_points:
		result_label.text = "Gelijk"
	if player_1_points > player_2_points:
		result_label.text = "speler 2 wint"
	if player_1_points < player_2_points:
		result_label.text = "speler 1 wint"
	result_modal.visible = true

func _on_reset_button_pressed():
	reset_game.emit(self, THE_BOMB)

func _on_return_button_pressed():
	continue_exercise.emit()
	get_tree().queue_delete(self)
