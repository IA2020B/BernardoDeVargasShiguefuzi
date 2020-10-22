extends KinematicBody2D

# Váriaveis de movimento
var MAX_SPEED = 250
var ACCELERATION = 1000
var motion = Vector2.ZERO

# Função de processo de física
func _physics_process(delta):
	# Controles
	var axis = get_input_axis()
	
	# Se o vetor de controle for igual a (0,0), aplique fricção (colisão)
	# Se não, aplique movimento
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	
	# Método de movimento 
	motion = move_and_slide(motion)

# Função para input do jogador
func get_input_axis():
	# Vetor de movimento
	var axis = Vector2.ZERO
	
	# Controles
	axis.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	axis.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	
	# Retorne o valor de movimento 
	return axis.normalized()

# Função de fricção de movimento
func apply_friction(amount):
	# Se movimento for maior que amount, reduza o movimento
	# Se não, movimento é (0,0)
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

# Função de movimento
func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
