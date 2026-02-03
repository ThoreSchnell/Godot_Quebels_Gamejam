extends CharacterBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var path: Path2D
@export var path_follow: PathFollow2D
@export var move_speed: float = 100.0
@export var loop_path: bool = true

var anim_name: String
var last_position: Vector2

func _ready() -> void:
	position = path_follow.global_position
	last_position = position

func _physics_process(delta: float) -> void:
	path_follow.progress += move_speed * delta
	# Nutze global_position statt position
	global_position = path_follow.global_position 
	
	var movement := global_position - last_position
	_update_animation(movement)
	last_position = global_position
	print(last_position)
func _update_animation(movement: Vector2) -> void:
	# Wir prüfen, ob die Länge des Vektors fast Null ist
	if movement.length() < 0.1:
		anim_name = "Idle_"
	else:
		anim_name = "Walk_"
		
	# Die Richtungs-Logik (jetzt korrekt eingerückt)
	anim_name += (
		"right" if abs(movement.x) > abs(movement.y) and movement.x > 0
		else "left" if abs(movement.x) > abs(movement.y)
		else "down" if movement.y > 0 else "up"
	)
	
	if anim_player.has_animation(anim_name) and anim_player.current_animation != anim_name:
		anim_player.play(anim_name)
	
	if anim_player.current_animation != anim_name:
		anim_player.play(anim_name)
