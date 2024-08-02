extends ScreenButton

@onready var items = StaticData.itemData["data"]
@onready var v_box_container = $"../TypeSelect/ScrollContainer/VBoxContainer"
@onready var exercises = $"../Exercises"
@onready var h_slider_amount = $"../Sliders/HSliderAmount"

var save_file_path = "user://exercise_list.save"
var exercise_list = []

func _ready():
	pass

func _on_pressed():
	var checks = v_box_container.get_children()
	var types = []
	var amount = h_slider_amount.value

	for check in checks:
		if check.button_pressed:
			types.append(check.get_index())

	for type in types:
		var item_exercises = items[type]["exercises"]
		var indexes = MyUtility.get_random_numbers(0, item_exercises.size()).slice(0, amount)
		for index in indexes:
			var item_exercise = item_exercises[index]
			exercise_list.append(item_exercise)
			exercises.add_item(str(type) + ": " +
				str(item_exercise["first"]) 
				+ " " + 
				str(item_exercise["operator"]) 
				+ " " + 
				str(item_exercise["second"])
				)
	
	save_exercise_list()
	exercise_list = []
	clicked.emit(self)


func save_exercise_list():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(exercise_list)
	print("saving list to disk...")
	file.close()

func load_exercise_list():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		var list = file.get_var()
		print(list)
		file.close()
	else:
		pass
