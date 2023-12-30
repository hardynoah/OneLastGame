class_name Enemy
extends CharacterBody2D

@export var health: int = 20
@export var attackDamage: int = 2
@export var friction: int = 25
@export var dealsKB: int = 25

func _physics_process(_delta):
	velocity.x = move_toward(velocity.x, 0, friction)
	velocity.y = move_toward(velocity.y, 0, friction)
	move_and_slide()
	

func takeDamage(damage):
	health = health - damage
	print(self.name + " took " + str(damage) + (" damage!"))
	if (health <= 0):
		enemyKilled()

func takeKnockback(knockback, sourcePos):
	velocity = sourcePos.direction_to(self.global_position) * knockback
	#print(velocity)

func enemyKilled():
	self.queue_free()
