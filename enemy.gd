extends Area2D

func explode():
	remove_from_group("enemies")
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("default")
	$Sprite2D.visible = false
	await $AnimatedSprite2D.animation_finished
	queue_free()
