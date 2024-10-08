extends CanvasLayer

@onready var title_screen = $TitleScreen
@onready var options_screen = $OptionsScreen
@onready var exercise_screen = $ExerciseScreen

var current_screen = null

func _ready():
	register_buttons()
	change_screen(title_screen)

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)

func _on_button_pressed(button):
	match button.name:
		"TitlePlay":
			await get_tree().create_timer(0.6).timeout
			change_screen(options_screen)
		"OptionsPlay":
			await get_tree().create_timer(0.25).timeout
			change_screen(exercise_screen)
			exercise_screen.start_exercises()
		"BackToOptions":
			await get_tree().create_timer(0.25).timeout
			change_screen(options_screen)
			options_screen.clear()
			await get_tree().create_timer(0.25).timeout
			exercise_screen.clear()
		"Return":
			await get_tree().create_timer(0.25).timeout
			change_screen(options_screen)
			options_screen.clear()
			await get_tree().create_timer(0.25).timeout
			exercise_screen.clear()

func change_screen(new_screen):
	if current_screen:
		var disappear_tween = current_screen.disappear()
		await(disappear_tween.finished)
		current_screen.visible = false
	current_screen = new_screen
	if current_screen:
		var appear_tween = current_screen.appear()
		await(appear_tween.finished)
		get_tree().call_group("buttons", "set_disabled", false)
