extends Sprite2D


@export var player_data : Resource


func _process(delta):
	global_rotation = global_position.direction_to(player_data.player_position).angle() + PI/2
