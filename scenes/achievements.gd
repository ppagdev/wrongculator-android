extends RichTextLabel

var achievements = {
	"COWARD" : false,
	"A2" : false,
	"A3" : false,
}

func save_achievements():
	var json_string = JSON.stringify(achievements)
	var save_file = FileAccess.open("user://achievements.save", FileAccess.WRITE)
	save_file.store_string(json_string)
	print("Achievements saved successfully.")

func load_achievements():
	if not FileAccess.file_exists("user://achievements.save"):
		print("No achievements file found.")
		return
	var load_file = FileAccess.open("user://achievements.save", FileAccess.READ)
	var json = JSON.new()
	var json_data = load_file.get_as_text()
	var _parse_result = json.parse(json_data)
	var achievements_data = json.get_data()
	load_file.close()
	if achievements_data is Dictionary:
		for a in achievements_data.keys():
			achievements[a] = achievements_data[a]
		print("Achievements loaded successfully.")
	else:
		print("Failed to load achievements data.")

func achieve(a):
	achievements[a] = true
	save_achievements()

func displayAchievements():
	var total = len(achievements)
	var completed = 0
	for a in achievements:
		if achievements[a]:
			completed += 1
	self.text = "%d out of %d achievements completed." % [completed, total]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	displayAchievements()
