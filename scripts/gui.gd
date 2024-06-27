extends Control

@onready var tempo = $Tempo/Label_Tempo
@onready var pontos = $Pontos/Label_Pontos
@onready var vidas = $Vidas/Label_Vidas


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	vidas.text = str(Global.vidas)
	pontos.text = str(Global.pontos)
