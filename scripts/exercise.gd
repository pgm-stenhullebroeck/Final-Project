extends BaseScreen

@onready var first_nr = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/FirstNr
@onready var operator = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/Operator
@onready var second_nr = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/SecondNr
@onready var answer_input = $NinePatchRect/MarginContainer/ExerciseContainer/HBoxContainer/InputBox/AnswerInput
@onready var check_btn = $NinePatchRect/MarginContainer/ExerciseContainer/Control/CheckBtn
@onready var submit_btn = $NinePatchRect/MarginContainer/ExerciseContainer/Control/SubmitBtn

var save_file_path = "user://exercise_list.save"
var exercise_list = []
var current_exercise = 0
var correct_answers = 0
var answer_list = []

func _ready():
	pass

func start_exercises():
	load_exercise_list()
	first_nr.text = str(exercise_list[0]["first"]) 
	operator.text = str(exercise_list[0]["operator"])
	second_nr.text = str(exercise_list[0]["second"]) 

func load_exercise_list():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		exercise_list = file.get_var()
		file.close()

func set_exercise():
	if current_exercise <= exercise_list.size() - 1:
		first_nr.text = str(exercise_list[current_exercise]["first"]) 
		operator.text = str(exercise_list[current_exercise]["operator"])
		second_nr.text = str(exercise_list[current_exercise]["second"])
	else:
		submit_btn.visible = true
		print('finished')
		print("Eindscore: ", correct_answers, "/", exercise_list.size())

func _on_check_btn_pressed():
	var input_answer: int
	var answer: int
	
	if answer_input.text:
		input_answer = int(answer_input.text)
		if exercise_list[current_exercise]["operator"] == "+":
			answer = exercise_list[current_exercise]["first"] + exercise_list[current_exercise]["second"]
		else: 
			answer = exercise_list[current_exercise]["first"] - exercise_list[current_exercise]["second"]
		
		if int(answer_input.text) == answer:
			print('succes')
			correct_answers += 1
		else:
			print('fail')
		
		current_exercise += 1
		answer_input.text = ''
		set_exercise()
	else:
		print('no input')
