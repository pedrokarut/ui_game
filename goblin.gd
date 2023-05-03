extends CharacterBody2D

const ATACK_AREA: PackedScene = preload("res://enemy_atack_area.tscn")
const OFFSET: Vector2 = Vector2(0,31)

var player_ref: CharacterBody2D = null
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var animation_aux: AnimationPlayer = get_node("AnimationPlayer2")
@onready var texture: Sprite2D = get_node("Texture")
@export var move_speed: float = 150.0
@export var distance_enemy: float = 70.0
@export var health: int = 3
@export var can_die: bool = false

func _physics_process(delta):
	if can_die:
		return
	
	if player_ref == null or player_ref.can_die:
		velocity = Vector2.ZERO
		animate()
		return
		
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance: float = global_position.distance_to(player_ref.global_position)
	

	if distance <= distance_enemy and distance != 0:
		animation.play("atack")
		return
	
	velocity = direction * move_speed
	move_and_slide()
	animate()
	
func spawn_atack_area():
	var atack_area = ATACK_AREA.instantiate()
	atack_area.position = OFFSET
	add_child(atack_area)	
	
func animate():
	if velocity < Vector2.ZERO:
		texture.flip_h = true
		animation.play("run")
		return
	if velocity > Vector2.ZERO:
		texture.flip_h = false
		animation.play("run")
		return
	animation.play("idle")
	
func update_health(value):
	animation.play("hit")
	health -= value
	if health <=0:
		can_die = true
		animation_aux.play("dead")


func _on_area_detection_body_entered(body):
	if body.name == "CharacterBody2D":
		player_ref = body


func _on_area_detection_body_exited(_body):
	player_ref = null
