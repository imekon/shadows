extends Spatial

onready var craft = $Craft

const SPEED = 1
const RANGE = 20

func _process(delta):
	var z = craft.translation.z
	z = z + delta * SPEED
	if z > RANGE:
		z = -RANGE
	craft.translation.z = z
