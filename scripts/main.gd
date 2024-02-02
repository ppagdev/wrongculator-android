extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print("WRONGCULATOR IS NOW ACTIVE!!!")

func resetDisplay():
	var display = get_node("VSplitContainer/Label")
	display.text = ""

func appendToDisplay(arg):
	var display = get_node("VSplitContainer/Label")
	if display.text.length() >= 8:
		return
	display.text += arg

func _on_button_pressed(arg):
	appendToDisplay(str(arg))


func _on_button_clr_pressed():
	resetDisplay()
