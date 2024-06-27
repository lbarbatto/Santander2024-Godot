extends Path2D

const LETRA = preload("res://cenas/letra.tscn")
@onready var caminho = $caminho
@onready var timer_spaw = $TimerSpaw
@onready var timer_level = $TimerLevel
@onready var musica = $musica
@onready var contador = $Contador


var game_status = Global.game_status
var spaw_seconds = 5
var level_seconds = 5

func _ready():
	match game_status:
		# PAUSE
		0:
			pass
		# PLAY
		1:
			musica.volume_db = Global.volume_global
			musica.play()
			timer_spaw.start(spaw_seconds)
			timer_level.start(level_seconds)
			contador.start()
		# GAMEOVER
		2:
			pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	musica.volume_db = Global.volume_global
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
			timer_spaw.stop()
			timer_level.stop()
			contador.stop()
			

func get_point() -> Vector2:
	caminho.progress_ratio = randf()
	return caminho.position


func _on_timer_timeout():
		var letra = LETRA.instantiate()
		letra.position = get_point()
		get_parent().add_child(letra)
		timer_spaw.start(spaw_seconds)


func _on_timer_level_timeout():
	if spaw_seconds > 0.5:
		spaw_seconds -= 0.1
		timer_level.start(level_seconds)


func _on_musica_finished():
	musica.volume_db = Global.volume_global
	musica.play()


func _on_contador_timeout():
	Global.tempo += 1
