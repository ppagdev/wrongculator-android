extends Control

var char_limit = 12
var coward = false
@onready var achievements_node = get_node("PanelContainer3/AchievementsPopup")
@onready var display = get_node("VSplitContainer/Label")
# Called when the node enters the scene tree for the first time.
func _ready():
	print("WRONGCULATOR IS NOW ACTIVE!!!")
	achievements_node.load_achievements()

func backspace():
	display.text = display.text.left(display.text.length()-1)

func wrongculate(expression):
	if coward:
		achievements_node.achieve("COWARD")
		return expression
	var rng = RandomNumberGenerator.new()
	if rng.randi_range(0,2):
		return expression
	var num = str(rng.randi_range(-5, 5))
	expression += "+ " + num
	return expression

func evaluateExpression():
	var text = wrongculate(display.text)
	var expression = Expression.new() 
	if expression.parse(text):
		resetDisplay()
		appendToDisplay("ERROR")
		return

	var result = expression.execute()
	
	result = str(result)
	resetDisplay()
	appendToDisplay(result)

func resetDisplay():
	display.text = ""

func appendToDisplay(arg):
	if display.text == "ERROR":
		resetDisplay()
	if display.text.length() >= char_limit:
		display.text = display.text.substr(0,char_limit)
		return
	display.text += arg

func _on_button_pressed(arg):
	appendToDisplay(arg)


func _on_button_clr_pressed():
	resetDisplay()


func _on_button_equals_pressed():
	if display.text == "ERROR":
		return
	evaluateExpression()


func _on_button_backspace_pressed():
	backspace()


func _on_coward_mode_toggled(toggled_on):
	coward = toggled_on
	if toggled_on:
		get_node("PanelContainer/CowardMode").text = "Coward"
	else:
		get_node("PanelContainer/CowardMode").text = "Normal"


func _on_button_achievements_pressed():
	var panel = get_node("PanelContainer3")
	panel.set_visible(!panel.is_visible())
