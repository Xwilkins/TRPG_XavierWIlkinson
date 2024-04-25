extends Control

signal textbox_closed

@export var enemy: Resource = null
var current_player_health = 50
var current_enemy_health = 0
var is_defending = false

func _ready():
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($"PlayerPanel/Player Data/ProgressBar", BattleState.current_health, BattleState.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	 
	current_enemy_health = BattleState.current_health
	current_enemy_health = enemy.health
	$Textbox.hide()
	$ActionPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name.to_upper())
	await "textbox_closed"
	$ActionPanel.show()
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]
	
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")
	
func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text



func _on_run_pressed():
	display_text("Got away safely!")
	await "textbox_closed"
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://over_world.tscn")
	
	

func _on_attack_pressed():
	display_text("You swing at the enemy")
	await "textbox_closed"
	
	current_enemy_health = max(0, current_enemy_health - BattleState.player_damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("EnemyDamaged")
	await $AnimationPlayer
	
	display_text("You dealt %d damage!" % BattleState.player_damage)
	await "textbox_closed"
	
	if current_enemy_health == 0:
		display_text("%s has been slain" % enemy.name.to_upper())
		await "textbox_closed"
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://over_world.tscn")
		
	
	enemy_turn()
	
func _on_defend_pressed():
	is_defending = true
	
	display_text("You enter a defensive stance")
	await "textbox_closed"
	
	await get_tree().create_timer(1.5).timeout
	
	enemy_turn()

func enemy_turn():
	display_text("%s attacks you!" % enemy.name.to_upper())
	await "textbox_closed"
	
	if is_defending:
		is_defending = false
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($"PlayerPanel/Player Data/ProgressBar", current_player_health, BattleState.max_health)
		
	
	
	
	display_text("%s dealt %d damage!" % [enemy.name, enemy.damage])
	await "textbox_closed"
	
	
	

