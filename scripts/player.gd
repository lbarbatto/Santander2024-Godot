extends CharacterBody2D

@onready var anim = $anim
@onready var ray = $ray
@onready var die = $die

var game_status = Global.game_status

var direction: int = 1
const SPEED = 150.0

var hurt = false
var dead = false


func _physics_process(_delta):
	volume_global()
	game_status = Global.game_status
	match game_status:
		#PAUSE
		0:
			pass
		# PLAY
		1:
			if hurt:
				aplica_dano()
			else:
				movimenta()
		# GAMEOVER
		2:
			pass


func movimenta():
	# Movimenta o player e toca animação
	velocity.x = direction * SPEED
	anima(direction, "run")
	
	# Captura o input e muda a direção
	if Input.is_action_just_pressed("ui_accept") || ray.is_colliding():
		direction *= -1
		ray.target_position *= -1
		anima(direction, "run")
		velocity.x = direction * SPEED

	# Aplica o movimento
	move_and_slide()

# Função para mudar a animação. Aplica a direção e toca a animação.
func anima(direcao, animation):
	anim.scale.x = direcao
	anim.play(animation)

func aplica_dano():
	hurt = true
	anima(direction, "hurt")
	modulate = "#ff0000"
	
func morte():
	dead = true
	anima(direction, "die")
	Global.game_status = 2
	die.play()

func _on_anim_animation_finished():
	modulate = "#ffffff"
	hurt = false
	
func volume_global():
	die.volume_db = Global.volume_global
