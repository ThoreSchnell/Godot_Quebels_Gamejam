extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var cardianl_direction : Vector2 = Vector2.DOWN
var state : String = "Idle"
@export var movement_speed : float = 100
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
func _ready():
	pass
	
func _process(_delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = direction * movement_speed
	
	if SetState() == true || SetDirection() == true:
		UpdateAnimation()
	
	
	pass
	
func _physics_process(_delta):
	move_and_slide()
	
func SetDirection() -> bool:
	var new_direction : Vector2 = cardianl_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y <0 else Vector2.DOWN
	
	if new_direction == cardianl_direction:
		return false
	
	cardianl_direction = new_direction
	return true
	
func SetState() -> bool:
	var new_state : String = "Idle" if direction == Vector2.ZERO else "Walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
func UpdateAnimation() -> void:
	animation_player.play( state + "_" + AnimDirection())
	pass

func AnimDirection()-> String:
	if cardianl_direction == Vector2.RIGHT:
		return "right"	
	elif cardianl_direction == Vector2.LEFT:
		return "left"
	elif cardianl_direction == Vector2.UP:
		return "up"
	else: 
		return "down"


		
