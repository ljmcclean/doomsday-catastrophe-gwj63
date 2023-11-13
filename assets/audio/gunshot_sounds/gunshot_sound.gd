extends AudioStreamPlayer2D

@export var gunshot_sounds : Array [AudioStreamWAV]

var randomizer : AudioStreamRandomizer

func _ready():
	randomizer = get_stream()
	var counter: int = 0
	for sound in gunshot_sounds:
		randomizer.add_stream(counter, sound, 1)
		counter += 1
