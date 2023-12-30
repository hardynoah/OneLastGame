extends CharacterBody2D

#Onready links to other files
@onready var duckSprite = $DuckSprite
@onready var animation = $DuckSprite/AnimationPlayer
@onready var punchTimer = $DuckSprite/punchTimer
@onready var punchParticles = $DuckSprite/PunchParticles
@onready var punchArea = $PunchArea/PunchHitBox

# Movement and Base Stats
@export var moveSpeed = 200.0
@export var health: int = 100

#ATTACK VALUES
@export var punchDmg = 9
@export var punchKB = 400


var isPunching : bool = false

func _ready():
	punchArea.set_disabled(true)

func _physics_process(_delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var curMoveSpeed = moveSpeed
	if (isPunching):
		curMoveSpeed = moveSpeed * .125
	
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * curMoveSpeed
	
	if (velocity.x < 0):
		punchParticles.position.x = -abs(punchParticles.position.x)
		punchParticles.initial_velocity_min = -abs(punchParticles.initial_velocity_min)
		punchParticles.initial_velocity_max = -abs(punchParticles.initial_velocity_max)
		if(!isPunching):
			duckSprite.flip_h = true
			punchArea.position.x = -abs(punchArea.position.x)
	elif (velocity.x > 0):
		punchParticles.position.x = abs(punchParticles.position.x)
		punchParticles.initial_velocity_min = abs(punchParticles.initial_velocity_min)
		punchParticles.initial_velocity_max = abs(punchParticles.initial_velocity_max)
		if(!isPunching):
			punchArea.position.x = abs(punchArea.position.x)
			duckSprite.flip_h = false
	
	updateAnimations()
	move_and_slide()

func updateAnimations():
	if (velocity == Vector2.ZERO and !isPunching):
		animation.play("default")
	elif (velocity != Vector2.ZERO and !isPunching):
		animation.play("walking")
	
	if (Input.is_action_just_pressed("punch") and !isPunching):
		punchTimer.start()
		punchArea.set_disabled(false)
		isPunching = true
		animation.play("punch")
		punchParticles.emitting = true

func _on_punch_timer_timeout():
	isPunching = false
	punchArea.set_disabled(true)

func takeDamage(damage):
	health = health - damage
	print("took " + str(damage) + (" damage!"))
	if (health <= 0):
		playerDied()

func takeKnockback(knockback, sourcePos):
	velocity = sourcePos.direction_to(self.global_position) * knockback
	#print(velocity)

func playerDied():
	print("L bozo")
