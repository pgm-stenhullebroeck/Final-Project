extends NinePatchRect

var item_count: int
var exercises_count: int
var amount = 5

@onready var vbox = $ScrollContainer/VBoxContainer
@onready var item_list = $"../ItemList"
@onready var exercises = $"../Exercises"

@onready var items = StaticData.itemData["data"]

var checks: Array

func _ready():
	for item in items:
		var checkbox = CheckBox.new()
		checkbox.text = item["name"]
		vbox.add_child(checkbox)
	checks = vbox.get_children()
	for check in checks:
		check.toggled.connect(_on_check_box_toggled.bind(check))

func _on_check_box_toggled(checked: bool, box: CheckBox):
	if checked:
		item_list.add_item(box.text, null, false)
	else:
		item_count = item_list.get_item_count()
		exercises_count = exercises.get_item_count()
		var exercises_to_remove = []
		for i in item_count:
			if item_list.get_item_text(i) == box.text:
				item_list.remove_item(i)
		for i in exercises_count:
			if exercises.get_item_text(i).left(1) == str(box.get_index()):
				exercises_to_remove.append(i)
		exercises_to_remove.reverse()
		for i in exercises_to_remove:
			exercises.remove_item(i)

func get_random_numbers(from, to):
	var arr = []
	for i in range(from, to):
		arr.append(i)
	arr.shuffle()
	return arr
