extends Projectile

func _ready():
	Sound.play(Sound.bullet, randf_range(0.6,1.2))
	set_process(false)
