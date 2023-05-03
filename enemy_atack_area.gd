extends Area2D

@export var damage:int = 1

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		body.update_health(damage)


func _on_timer_timeout():
	queue_free()
