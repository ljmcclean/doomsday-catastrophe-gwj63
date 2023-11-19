extends CharacterBody2D

@export var player_data : Resource

var player_in_pickup_range: bool = false

func _physics_process(_delta):
	if player_in_pickup_range:
		velocity = 100 * position.direction_to(player_data.player_position)
		move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("pickup_range"):
		player_in_pickup_range = true



func _on_area_2d_body_entered(body):
	if body.name == "Cat":
		$CoinPickup.play()
		player_data.currency += 1
		await $Pickup.play()
		
		queue_free()
