class_name HurtBox
extends Area2D


# Called when the node enters the scene tree for the first time.
func _init():
	collision_layer = 0
	collision_mask = 2
	
func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null or hitbox.owner == owner:
		return
	
	if owner.has_method("takeDamage"):
		owner.takeDamage(hitbox.damage)

	if owner.has_method("takeKnockback"):
		owner.takeKnockback(hitbox.knockback, hitbox.attackerPos)
