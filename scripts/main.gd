extends Control

var char_limit = 12

# Called when the node enters the scene tree for the first time.
func _ready():
	print("WRONGCULATOR IS NOW ACTIVE!!!")

func backspace():
	var display = get_node("VSplitContainer/Label")
	display.text = display.text.left(display.text.length()-1)

func wrongculate(expression):
	var rng = RandomNumberGenerator.new()
	if rng.randi_range(0,2):
		return expression
	var num = str(rng.randi_range(-5, 5))
	expression += "+ " + num
	return expression

func evaluateExpression():
	var display = get_node("VSplitContainer/Label")
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
	var display = get_node("VSplitContainer/Label")
	display.text = ""

func appendToDisplay(arg):
	var display = get_node("VSplitContainer/Label")
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
	evaluateExpression()


func _on_button_backspace_pressed():
	backspace()
