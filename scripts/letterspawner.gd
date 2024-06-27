extends Path2D

@onready var caminho = $caminho
@onready var timer = $TimerSpaw
const LETRA = preload("res://cenas/letra.tscn")
@onready var musica = $musica

var game_status = Global.game_status

var seconds = 5


func _ready():
	match game_status:
		# PAUSE
		0:
			pass
		# PLAY
		1:
			musica.play()
			timer.start(seconds)
		# GAMEOVER
		2:
			pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	game_status = Global.game_status
	match game_status:
		# PAUSE
		0:
			pass
		# PLAY
		1:
			pass
		# GAMEOVER
		2:
			musica.stop()
			timer.stop()
			

func get_point() -> Vector2:
	caminho.progress_ratio = randf()
	return caminho.position


func _on_timer_timeout():
		var letra = LETRA.instantiate()
		letra.position = get_point()
		get_parent().add_child(letra)
		timer.start(seconds)


func _on_timer_level_timeout():
	if seconds > 0.5:
		seconds -= 0.1


func _on_musica_finished():
	musica.play()
