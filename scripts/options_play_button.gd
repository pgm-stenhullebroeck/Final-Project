extends ScreenButton

@onready var items = StaticData.itemData["data"]
@onready var v_box_container = $"../ScrollContainer/VBoxContainer"
@onready var h_slider_amount = $"../Sliders/HSliderAmount"
@onready var h_slider_interval = $"../Sliders/HSliderInterval"
@onready var h_slider_game = $"../Sliders/HSliderGame"

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
	if !types.is_empty():
		for type in types:
			var item_exercises = items[type]["exercises"]
			var indexes = MyUtility.get_random_numbers(0, item_exercises.size()).slice(0, amount)
			for index in indexes:
				var item_exercise = item_exercises[index]
				exercise_list.append(item_exercise)
		randomize()
		exercise_list.shuffle()
		save_exercise_list()
		exercise_list = []
		clicked.emit(self)


func save_exercise_list():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(exercise_list)
	file.store_var(h_slider_interval.value)
	file.store_var(h_slider_game.value)
	print("saving list to disk...")
	file.close()
