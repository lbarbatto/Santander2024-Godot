extends Control

@onready var tempo = $Tempo/Label_Tempo
@onready var pontos = $Pontos/Label_Pontos
@onready var vidas = $Vidas/Label_Vidas
@onready var volume = $volume
@onready var som = $som
@onready var pause = $pause
@onready var texture_button = $TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_status == 2:
		pause.disabled = true
	else:
		pause.disabled = false
	vidas.text = str(Global.vidas)
	pontos.text = str(Global.pontos)
	tempo.text = str(Global.tempo)


func _on_pause_pressed():
	if Global.game_status == 0:
		Global.game_status = 1
		Engine.time_scale = 1
		Global.volume_global = volume.max_value
	else:
		Global.game_status = 0
		Engine.time_scale = 0
		Global.volume_global = volume.min_value


func _on_som_pressed():
	if volume.value > volume.min_value:
		volume.value = volume.min_value
	else:
		volume.value = volume.max_value


func _on_volume_value_changed(value):
	if value == volume.min_value:
		som.button_pressed = true
	else:
		som.button_pressed = false
	Global.volume_global = value



