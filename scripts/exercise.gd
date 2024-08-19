extends BaseScreen

@onready var first_nr = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/FirstNr
@onready var operator = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/Operator
@onready var second_nr = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/SecondNr
@onready var answer_input = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/InputBox/AnswerInput
@onready var check_btn = $NinePatchRect/MarginContainer/ExerciseContainer/CheckBtnBox/CheckBtn 
@onready var result_modal = $ResultModal
@onready var result_label = $ResultModal/MarginContainer/NinePatchRect2/ResultsContainer/ResultLabel
@onready var numpad_container = $NinePatchRect/NumpadContainer
@onready var status_modal = $StatusModal

const TIC_TAC_TOE = preload("res://scenes/tic_tac_toe.tscn")
const THE_BOMB = preload("res://scenes/the_bomb.tscn")

const Succes = preload("res://assets/textures/character/smile-sprite.png")

const save_file_path: String = "user://exercise_list.save"
var exercise_list: Array = []
var current_exercise:int = 0
var correct_answers: int = 0
var answer_list: Array = []
var interval: int = 0
var game: int = 0

func start_exercises():
	load_exercise_list()
	first_nr.text = str(exercise_list[0]["first"]) 
	operator.text = str(exercise_list[0]["operator"])
	second_nr.text = str(exercise_list[0]["second"]) 

func load_exercise_list():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		exercise_list = file.get_var()
		interval = file.get_var()
		game = file.get_var()
		file.close()

func set_exercise():
	if current_exercise <= exercise_list.size() - 1:
		first_nr.text = str(exercise_list[current_exercise]["first"]) 
		operator.text = str(exercise_list[current_exercise]["operator"])
		second_nr.text = str(exercise_list[current_exercise]["second"])
	else:
		#submit_btn.visible = true
		get_tree().call_group("buttons", "set_disabled", false)
		result_modal.visible = true
		result_label.text = str("Eindscore: ", correct_answers, "/", exercise_list.size())

func _on_check_btn_pressed():
	var input_answer: int
	var answer: int
	
	if answer_input.text:
		input_answer = int(answer_input.text)
		if exercise_list[current_exercise]["operator"] == "+":
			answer = exercise_list[current_exercise]["first"] + exercise_list[current_exercise]["second"]
		else: 
			answer = exercise_list[current_exercise]["first"] - exercise_list[current_exercise]["second"]
		
		if input_answer == answer:
			status_modal.texture_rect.set_texture(Succes)
			status_modal.label.text = "Goed zo"
			status_modal.appear()
			await get_tree().create_timer(0.75).timeout
			status_modal.disappear()
			await get_tree().create_timer(0.4).timeout
			status_modal.visible = false
			correct_answers += 1
		else:
			status_modal.texture_rect.set_texture(null)
			status_modal.label.text = str(answer)
			status_modal.appear()
			await get_tree().create_timer(2).timeout
			status_modal.disappear()
			await get_tree().create_timer(0.4).timeout
			status_modal.visible = false
		get_tree().call_group("buttons", "set_disabled", false)
		current_exercise += 1
		answer_input.text = ''
		set_exercise()
		if current_exercise % interval == 0:
			if game > 0:
				choose_game(game)
			else:
				choose_game(randi_range(1, 2))

func choose_game(game):
	if game == 1:
		start_game(TIC_TAC_TOE)
	else:
		start_game(THE_BOMB)

func _on_answer_input_text_submitted(_new_text):
	check_btn.pressed.emit()

func start_game(game_scene):
	var game = game_scene.instantiate()
	self.add_child(game)
	game.reset_game.connect(_reset_game)

func _reset_game(game, game_scene):
	game.queue_free()
	start_game(game_scene)

func clear():
	result_modal.visible = false
	current_exercise = 0
	correct_answers = 0
	answer_list = []
