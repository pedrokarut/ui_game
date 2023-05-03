extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var warrior: Sprite2D = get_node("Warrior")
@onready var collisionAtack: CollisionShape2D = get_node("AtackArea/CollisionAtack")

var can_atack: bool = true
var can_die = false
@export var move_speed: float = 256.0
@export var damage: int = 1
@export var health: int = 5

func _physics_process(delta):
		if !can_die:
			move()
			animate()
	
func move():
	var direction: Vector2 = get_direction()
	velocity = direction * move_speed
	move_and_slide()
	
func get_direction() -> Vector2:
	return Vector2(Input.get_axis("move_left", "move_right"),	
	Input.get_axis("move_up", "move_down")
	).normalized()
	
func animate():
	if velocity > Vector2.ZERO:
		warrior.flip_h = false
		collisionAtack.position.x = 63.5
		animation.play("run")
	if velocity < Vector2.ZERO:
		warrior.flip_h = true
		collisionAtack.position.x = -63.5
		animation.play("run")
	if velocity == Vector2.ZERO and !Input.is_anything_pressed():
		animation.play("idle")
	if Input.is_action_just_pressed("atack"):
		animation.play("atack")


func _on_atack_area_body_entered(body):
	body.update_health(damage)
	
func update_health(value):
	animation.play("hit")
	health -= value
	if health <=0:
		can_die = true
		animation.play("dead")
		
func die():
	collisionAtack.disabled = true
	get_tree().reload_current_scene()
