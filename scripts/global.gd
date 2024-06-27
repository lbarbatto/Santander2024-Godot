extends Node


var tempo = 0
var vidas = 3
var pontos = 0

var volume_global = 0

enum Status {PAUSE, PLAY, GAMEOVER}

var game_status = Status.PLAY
