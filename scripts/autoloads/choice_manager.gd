extends Node


enum GameMode {
	SINGLEPLAYER,
	MULTIPLAYER
}


var game_mode: GameMode = GameMode.SINGLEPLAYER
var selected_mod: Dictionary = {}
