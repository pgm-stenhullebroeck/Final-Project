extends NinePatchRect

var item_count: int
var exercises_count: int
var amount = 5

@onready var vbox = $ScrollContainer/VBoxContainer
@onready var item_list = $ItemList
@onready var button: Button = $Button

@onready var items = StaticData.itemData["data"]

var checks: Array

func _ready():
	for item in items:
		var checkbox = CheckBox.new()
		checkbox.text = item["name"]
		checkbox.mouse_filter = Control.MOUSE_FILTER_PASS
		vbox.add_child(checkbox)
	checks = vbox.get_children()
	for check in checks:
		check.toggled.connect(_on_check_box_toggled.bind(check))
		check.add_theme_font_size_override("checkbox_label", 36)

func _on_check_box_toggled(checked: bool, box: CheckBox):
	if checked:
		item_list.add_item(box.text, null, false)
	else:
		item_count = item_list.get_item_count()
		for i in item_count:
			if item_list.get_item_text(i) == box.text:
				item_list.remove_item(i)
	if item_list.get_item_count() == 0:
		button.disabled = true
	else:
		button.disabled = false
