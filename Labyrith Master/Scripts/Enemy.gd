extends KinematicBody2D
# Esse é o script dos inimigos. Contem uma máquina de estados finitos

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
var state = MOVE
var direction = Vector2.ZERO
var target = null

# Função p/ quando o nodo entra em cena
func _ready():
	# Seed aleatória (p/ estados)
	randomize()

# Função de processo (por tempo)
func _process(delta):
	# Estados (0)
	match state:
		# Parado
		IDDLE:
			pass
		
		ATTACK:
			attack_player()
		
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

# Função de movimento
func move (delta):
	position += direction * SPEED * delta
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

# Função para detectar quando o jogador entra no circulo de deteção
func _on_DetectionRange_body_entered(body):
	if body.name == "Player":
		target = body

# Função para atacar o jogador
func attack_player():
	pass

# Função para quando o jogador sair do campo de detecção
func _on_DetectionRange_body_exited(body):
	pass
