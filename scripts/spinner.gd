extends Node2D

onready var body = get_node("body")

var speed = 0
var accel = -2
var block = false

signal speed(value) #faz um sinal com argumentos
signal limit
signal zero

func _ready():
	set_process(true)

func _process(delta):
	if speed > 1:
		speed += accel * delta
	else:
		speed = 0
		accel = -2
		emit_signal("zero")
	
	body.set_rot(body.get_rot() + delta*speed)
	#emite o sinal como os valores devem ser ou 0 ou 1 se divide por 50 vel maxima
	emit_signal("speed", speed/50)

func _on_contact_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and not block:
		speed +=5
		if speed > 50:
			speed = 50
			emit_signal("limit")


func _on_btnBlack_pressed():
	get_node("body/image").set_texture(load("res://assets/black_ready.png"))


func _on_btnRed_pressed():
	get_node("body/image").set_texture(load("res://assets/red_ready.png"))


func _on_btnYellow_pressed():
	get_node("body/image").set_texture(load("res://assets/yellow_ready.png"))


func _on_mainGame_block():
	block = true
	accel = -10


func _on_mainGame_unBlock():
	block = false
