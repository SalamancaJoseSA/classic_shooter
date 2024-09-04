extends Area2D

@export var cooldown = 0.25
@export var bullet_scene : PackedScene
@export var charge_scene : PackedScene
@export var speed = 150
@onready var screensize = get_viewport_rect().size
var can_shoot = true
var weapontype = false
func _ready():
	$Timer.wait_time = cooldown

func swapproj():
	weapontype = !weapontype
	cooldown = 1

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$Timer.start()
	if weapontype == true:
		var c = charge_scene.instantiate()
		get_tree().root.add_child(c)
		c.start(position + Vector2(0,-8))
	elif weapontype == false:	
		cooldown = 0.25
		var b = bullet_scene.instantiate()
		var b2 = bullet_scene.instantiate()
		get_tree().root.add_child(b)
		get_tree().root.add_child(b2)
		b.start(position + Vector2(-5, -8))
		b2.start(position + Vector2(5, -8))

func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("switch"):
		swapproj()
	var input = Input.get_vector("left", "right", "up", "down")
	if input.x > 0:
		$Sprite2D.frame = 2
		$AnimatedSprite2D.animation = "right"
	elif input.x < 0:
		$Sprite2D.frame = 0
		$AnimatedSprite2D.animation = "left"
	else:
		$Sprite2D.frame = 1
		$AnimatedSprite2D.animation = "forward"
	position += input * speed * delta
	position = position.clamp(Vector2.ZERO, screensize)


func _on_timer_timeout() -> void:
	can_shoot = true
