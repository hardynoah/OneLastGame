extends HitBox

func _ready():
	damage = owner.punchDmg
	knockback = owner.punchKB
