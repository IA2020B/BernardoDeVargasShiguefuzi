extends KinematicBody2D
# ------------------------------------------- 
# Este é o script para os inimigos. Contém uma máquina de estados finitos que 
# governam a IA deles (7 estados: PARADO, ATACAR, PERSEGUIR, DETECTAR, FUGIR, 
# LOCOMOVER e ESCOLHER NOVA DIREÇÃO).
# -------------------------------------------
# Estados completos: IDDLE, MOVE, NEW_DIRECTION, DETECTION
# Estados a serem feitos: ATTACK, CHASE, FLEE
# -------------------------------------------

# Enum dos estados finitos
enum {
	IDDLE, 
	ATTACK, 
	CHASE, 
	DETECTION, 
	FLEE, 
	MOVE, 
	NEW_DIRECTION}

# Váriaveis 
const SPEED = 100
var state = NEW_DIRECTION
var direction = Vector2.ZERO
var target = null

# Node do jogador
onready var player = get_parent().get_node_and_resource("/root/Room/Player")

# Função p/ quando o nodo entra em cena
func _ready():
	# Seed aleatória (p/ estados)
	randomize()
	#print(player) --> Ignore

# Função de processo (por tempo)
func _process(delta):
	# Estados
	match state:
		# Parado
		IDDLE:
			pass
		
		# Atacar
		ATTACK:
			#attack_player(delta)
			pass
		
		# Perseguir
		CHASE:
			pass
		
		# Detectar jogador
		DETECTION:
			_on_DetectionRange_body_entered(target)
			state = ATTACK
		
		# Fugir do jogador
		FLEE:
			pass
		
		# Se mover em direção atual
		MOVE:
			move(delta)
		
		# Escolher nova direção
		NEW_DIRECTION:
			direction = choose([Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT])
			state = choose([IDDLE, MOVE])
	
	#print(state) --> Ignore

# Função de movimento
func move (delta):
	position += direction * SPEED * delta
# warning-ignore:return_value_discarded
	move_and_collide(direction)

# Função de escolha
func choose(array):
	# Embaralhe as opções da matriz e retorne o valor da frente
	array.shuffle()
	return array.front()

# Função de tempo (sinal)
func _on_Timer_timeout():
	# Pegue o timer na árvore e escolha novo estado
	$Timer.wait_time = choose([0.5, 1, 1.5])
	state = choose([IDDLE, MOVE, NEW_DIRECTION])

# Função para detectar quando o jogador entra no circulo de deteção (sinal)
func _on_DetectionRange_body_entered(body):
	if body.name == "Player":
		target = body
		#print(target) --> Ignore

# TODO: Função para atacar o jogador (comentário do programador: AAAAAARRRRRGGHH ACABE COM MEU SOFRIMENTO)
func attack_player(delta):
	target = player

# TODO: Função para quando o jogador sair do campo de detecção
func _on_DetectionRange_body_exited(body):
	pass
