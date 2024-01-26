extends Control

@export var levelText: Label;
@export var healthText: Label;
@export var weaponNameText: Label;
@export var weaponDamageText: Label;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Load():
	printt("Loading")


func Save():
	printt("Saving")
