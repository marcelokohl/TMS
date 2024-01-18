extends CanvasLayer


@onready var label : Label = get_node("Control/Label") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		label.text = "FPS:" + str(Engine.get_frames_per_second()) + "\n ENM:" + str(get_tree().get_node_count_in_group(("enemy")))
