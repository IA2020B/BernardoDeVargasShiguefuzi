extends KinematicBody2D

# Enum dos estados
enum {
	IDDLE, 
	ATTACK, 
	PERSUE, 
	FLEE, 
	MOVE,
	NEW_DIRECTION,
	DETECTION}

# Váriaveis 
const SPEED = 100
var state = MOVE
var direction = Vector2.RIGHT
var target = null

# Função p/ quando o nodo entra em cena
func _ready():
	# Seed aleatória (p/ estados)
	randomize()

# Função de processo (por tempo)
func _process(delta):
	# Estados
	match state:
		# Parado
		IDDLE:
			pass
		
		# Ataque o jogador 
		ATTACK:
			pass
		
		# Persiga o jogador 
		PERSUE:
			pass
		
		# Fuja do jogador 
		FLEE:
			pass
		
		# Se mova na direção atual
		MOVE:
			move(delta)
		
		# Escolha uma nova direção
		NEW_DIRECTION:
			# Escolha uma direção
			direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			# Escolha um novo estado
			state = choose([IDDLE, MOVE])
		
		# Detecte o jogador
		DETECTION:
			pass

# Função de movimento
func move(delta):
	position += direction * SPEED * delta
	move_and_collide(direction)

# Função de escolha
func choose(array):
	# Embaralhe as opções da matriz e retorne o valor da frente
	array.shuffle()
	return array.front()

# Função de tempo (sinal)
func _on_Timer_timeout():
	# Pegue o timer na árvore e escolha
	$Timer.wait_time = choose([0.5, 1, 1.5])
	state = choose([IDDLE, MOVE, NEW_DIRECTION])

# Função de detecção de jogador (sinal)
func _on_DetectionRange_body_entered(body):
	if body.name == "Player":
		target = body
		print ("Player found")
