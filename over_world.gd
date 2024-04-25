extends Node2D

@onready var _character = $"/root/BattleState"
@onready var _label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	_label.update_text(_character.player_level, _character.exp, _character.exp_req)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if not event.is_action_pressed("ui_accept"):
		return
	_character.gain_exp(50)
	_label.update_text(_character.player_level, _character.exp, _character.exp_req)
	
	
