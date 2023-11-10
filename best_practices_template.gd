extends Node
#Primary Programmer: Programmer Name

@export var export_variable : float

@onready var onready_variable: String = "Sample"

var standard_var: int = 10
const CONSTANT_VAR: float = 100.5

enum Direction
{
	UP,
	DOWN,
	LEFT,
	RIGHT
}


func _ready():
	pass


func sample_function(used_var: int, _unused_var: bool) -> void:
	pass
