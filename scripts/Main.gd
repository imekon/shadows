extends Spatial

onready var craft = $Craft
onready var crateSpawnPoint = $CrateSpawnPoint

const SPEED = 1
const RANGE = 20
const CRATE_OFFSET = 2

var crate

func _ready():
	randomize()
	crate = load("res://scenes/Crate.tscn")

func _process(delta):
	var z = craft.translation.z
	z = z + delta * SPEED
	if z > RANGE:
		z = -RANGE
	craft.translation.z = z

func on_crate_timeout():
	var inst = crate.instance()
	inst.translation = crateSpawnPoint.translation
	inst.translate(Vector3(randf() * CRATE_OFFSET, 0, randf() * CRATE_OFFSET))
	add_child(inst)