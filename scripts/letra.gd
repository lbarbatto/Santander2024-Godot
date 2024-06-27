extends RigidBody2D

@onready var particula = $particulaLetra
@onready var sprite = $sprite
@onready var colisor = $colisor
@onready var hurt = $hurt
@onready var coin = $coin
@onready var broke = $broke

const letras = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
const SPEED = 100

var game_status = Global.game_status

var vogais = ["a", "e", "i", "o", "u"]
var letra
var pontos

func _ready():
	sorteiaLetra()


func _process(_delta):
	volume_global()
	game_status = Global.game_status
	match game_status:
		# PAUSE
		0:
			pass
		# PLAY
		1:
			linear_velocity.y = SPEED
			if get_colliding_bodies():
				destroi()
		# GAMEOVER
		2:
			queue_free()


func marca_ponto():
	if vogais.filter(func(let): return let == letra):
		Global.pontos += 1
		coin.play()
	else:
		perde_vida()


func perde_vida():
	if Global.vidas > 0:
		Global.vidas -= 1
		hurt.play()
		get_parent().get_node("player").aplica_dano()
	else:
		get_parent().get_node("player").morte()


func destroi():
	colisor.disabled = true
	sprite.visible = false
	particula.emitting = true
	broke.play()


func _on_particula_letra_finished():
	queue_free()
	
	
func sorteiaLetra():
	var indice = randi_range(0,letras.size()-1)
	letra = letras[indice]
	sprite.play(letra)


func _on_body_entered(body):
	if body.is_in_group("player"):
		marca_ponto()
		
func volume_global():
	hurt.volume_db = Global.volume_global
	coin.volume_db = Global.volume_global
	broke.volume_db = Global.volume_global
	
