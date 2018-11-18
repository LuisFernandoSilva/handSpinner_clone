extends Node2D

var score1 = 0
var score2 = 0
var spinner1 = false
var spinner2 = false
var resetting
var time

signal block
signal unBlock

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func updateScore():
	get_node("control/player1/score").set_text(str(score2))
	get_node("control/player2/score").set_text(str(score1))
	
	emit_signal("block")
	spinner1 = false
	spinner2 = false



func _on_spinner1_limit():
	score1 += 1
	updateScore()
	get_node("control/player2/msg").set_text("You win")
	get_node("control/player1/msg").set_text("You lose")
	


func _on_spinner2_limit():
	score2 += 1
	updateScore()
	get_node("control/player1/msg").set_text("You win")
	get_node("control/player2/msg").set_text("You lose")


func _on_spinner1_zero():
	#spinner1 = true
	if not spinner2:
		reset()


func _on_spinner2_zero():
	#spinner2 = true
	if not spinner1:
		reset()
		
func reset():
	if resetting: return 
	resetting = true
	get_node("control/player1/msg").set_text("")
	get_node("control/player2/msg").set_text("")
	time = 5
	get_node("restart").start()

func _on_restart_timeout():
	time -= 1
	if time > 1:
		get_node("control/player1/msg").set_text(str(time))
		get_node("control/player2/msg").set_text(str(time))
	elif time == 1:
		get_node("control/player1/msg").set_text("Go!!")
		get_node("control/player2/msg").set_text("Go!!")
		resetting = false
		emit_signal("unBlock")
	elif time == 0:
		get_node("control/player1/msg").set_text("")
		get_node("control/player2/msg").set_text("")
		
