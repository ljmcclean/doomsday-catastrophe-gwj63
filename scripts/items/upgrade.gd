extends StaticBody2D

@export var upgrade_name : String 
@export var cost : int
@export var cost_increase : int
@export var player_data : Resource

@export var sprite : Texture2D


func _ready():
	$Sprite2D.texture = sprite


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and player_data.currency >= cost:
		player_data.currency -= cost
		player_data.upgrade(upgrade_name)
		cost += cost_increase
		$RichTextLabel.text = "[center]" + upgrade_name + " increased!"
		await get_tree().create_timer(1.2).timeout
		$RichTextLabel.text = ""

