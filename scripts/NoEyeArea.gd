extends Area2D



func _on_NoEyeArea_body_entered(body):
	if body.get_name() == "Nomed":
		body.allowed_opening_eye = false


func _on_NoEyeArea_body_exited(body):
	if body.get_name() == "Nomed":
		body.allowed_opening_eye = true
