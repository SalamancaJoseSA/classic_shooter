extends Node2D

var enemy = preload("res://enemy.tscn")
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func spawn_enemies():
	for x in 9:
		for y in 3:
			var e = enemy.instantiate()
			var pos = Vector2(x * (16+8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.position = pos

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
 
			
func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	spawn_enemies()
	$StartTimer.start()

func _ready():
	new_game()
