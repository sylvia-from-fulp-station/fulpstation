// This is triggered in roundend.dm, so that we have some round-end music instead of just playing lobby music again.
/client/playtitlemusic(vol = 85)
	if(SSticker.current_state == GAME_STATE_FINISHED)
		return playcreditsmusic(vol)
	return ..()

/client/proc/playcreditsmusic(vol = 85)
	set waitfor = FALSE

	var/volume_modifier = prefs.read_preference(/datum/preference/numeric/sound_lobby_volume)
	if((prefs && volume_modifier) && !CONFIG_GET(flag/disallow_title_music))
		SEND_SOUND(src, sound(returncreditsmusic(), repeat = 0, wait = 0, volume = volume_modifier, channel = CHANNEL_LOBBYMUSIC)) // MAD JAMS

// The proc that decides which track to play for the credits, from the G.credits_music global list
// This allows for a much easier time adding some more credits music.
/client/proc/returncreditsmusic()
	return pick_weight(GLOB.credits_music)
