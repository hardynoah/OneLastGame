extends HitBox

func _ready():
	damage = owner.attackDamage
	knockback = owner.dealsKB
