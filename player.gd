extends Area2D
@onready var screenSize = get_viewport_rect().size
@export var velocity = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Input.get_vector('left', 'right', 'up', 'down')
	if input.x < 0:
		$Ship.frame = 0
		$Ship/Boosters.animation = 'left'
	elif input.x > 0:
		$Ship.frame = 2
		$Ship/Boosters.animation = 'right'
	else:
		$Ship.frame = 1
		$Ship/Boosters.animation = 'forward'
	position += input * velocity * delta
	position = position.clamp(Vector2(8,8), screenSize - Vector2(8,8))
