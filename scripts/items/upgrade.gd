extends StaticBody2D

@export var upgrade_name : String 
@export var cost_increase : int
@export var player_data : Resource
@export var upgrade_data : Resource
@export var texture : Texture2D
var number_upgrades : int = 0

var cost : int

@export var sprite : Texture2D

var is_in_area: bool = false

func _ready():
	cost = upgrade_data.cost
	$Sprite2D.texture = sprite
	$Cost.text = "[center]" + str(cost)
	$Icon.texture = texture


func _on_area_2d_body_entered(body):
	cost = upgrade_data.cost
	$RichTextLabel.text ="[center]" + str(number_upgrades) + "/5"
	if body.is_in_group("player"):
		is_in_area = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false


func _input(event):
	if is_in_area and event.is_action_pressed("interact") and player_data.currency >= cost:
		number_upgrades+= 1
		$RichTextLabel.text ="[center]" + "number_upgrades" + "/5"
		apply_upgrade()
	elif is_in_area and event.is_action_pressed("interact"):
		$RichTextLabel.text = "[center]" + "Too expensive!"
		await get_tree().create_timer(1.2).timeout
		$RichTextLabel.text = ""


func apply_upgrade():
	player_data.currency -= cost
	player_data.upgrade(upgrade_name)
	cost += cost_increase
	$Cost.text = "[center]" + str(cost)
	$RichTextLabel.text = "[center]" + upgrade_name + " increased!"
	await get_tree().create_timer(1.2).timeout
	$RichTextLabel.text = ""
	upgrade_data.cost = cost
