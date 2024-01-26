# Note: the save/load logic in this script is not perfect. It is just for testing.

extends Control

@export var levelText: Label;
@export var healthText: Label;
@export var weaponNameText: Label;
@export var weaponDamageText: Label;

@export var weapon1: Weapon
@export var weapon2: Weapon

var playerSaveData: PlayerSaveData

# Called when the node enters the scene tree for the first time.
func _ready():
	Load()


func PressLevel():
	playerSaveData.level += 1
	UpdateUI()
	
func PressHealth():
	playerSaveData.health += 10
	UpdateUI()
	
func PressWeapon():
	playerSaveData.weapon = weapon1 if (playerSaveData.weapon.name == "Spear") else weapon2
	UpdateUI()

func UpdateUI():
	levelText.text = str(playerSaveData.level)
	healthText.text = str(playerSaveData.health)
	weaponNameText.text = playerSaveData.weapon.name
	weaponDamageText.text = str(playerSaveData.weapon.damage)

func Load():
	printt("Loading")
	
	# Create default data if no save data exists
	if not FileAccess.file_exists("user://save.data"):
		playerSaveData = PlayerSaveData.new()
		playerSaveData.level = 1
		playerSaveData.health = 100
		playerSaveData.weapon = weapon1
	else:
		# Get the file and convert it to json
		var saveFile = FileAccess.open("user://save.data", FileAccess.READ)
		var jsonString = saveFile.get_line()
		saveFile.close()
		var json = JSON.new()
		json.parse(jsonString)
		var data = json.get_data()
		
		# If needed, create a new player save data object
		if playerSaveData == null:
			playerSaveData = PlayerSaveData.new()
		
		# Get the data from the json
		playerSaveData.level = data["level"]
		playerSaveData.health = data["health"]
		playerSaveData.weapon = weapon1 if (data["weapon"] == "Sword") else weapon2
	
	UpdateUI()

func Save():
	printt("Saving")
	
	# Write the save data to the file
	var saveFile = FileAccess.open("user://save.data", FileAccess.WRITE)
	var data = {
		"level" : playerSaveData.level,
		"health" : playerSaveData.health,
		"weapon" : playerSaveData.weapon.name
	}
	var json = JSON.stringify(data)
	saveFile.store_line(json)
	saveFile.close()
