class_name HitBox
extends Area2D

@export var damage = 1
@export var knockback = 200
var attackerPos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _init():
	collision_layer = 2
	collision_mask = 0


func _process(_delta):
	attackerPos = owner.position
