extends Area2D
@onready var screenSize = get_viewport_rect().size
@export var velocity = 150
@export var cooldown = .25
@export var bullet_scene : PackedScene
var canShoot = true

func start():
	position = Vector2(screenSize.x / 2, screenSize.y - 64)
	$GunCoolDown.wait_time = cooldown
	
func shoot():
	if not canShoot:
		return
	canShoot = false
	$GunCoolDown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position + Vector2(0,-8))
	

# Called when the node enters the scene tree for the first time.
func _ready():
	start() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Input.get_vector('left', 'right', 'up', 'down')
	if input.x < 0:
		$Ship.frame = 0
		$Ship/Boosters.play('left')
	elif input.x > 0:
		$Ship.frame = 2
		$Ship/Boosters.play('right')
	else:
		$Ship.frame = 1
		$Ship/Boosters.play('forward')
	position += input * velocity * delta
	position = position.clamp(Vector2(8,8), screenSize - Vector2(8,8))
	
	if Input.is_action_pressed("shoot"):
		shoot()
		

func _on_gun_cool_down_timeout():
	canShoot = true
