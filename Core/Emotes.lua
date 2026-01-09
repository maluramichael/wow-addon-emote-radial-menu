local AddonName, Addon = ...

local EmoteManager = {}
Addon.EmoteManager = EmoteManager

local AVAILABLE_EMOTES = {
	"agree", "amaze", "angry", "apologize", "applaud", "arrogant",
	"bashful", "beckon", "beg", "belch", "bite", "bleed", "blink",
	"blush", "boggle", "bonk", "bored", "bounce", "bow", "brb",
	"burp", "bye", "cackle", "calm", "cheer", "chuckle", "clap",
	"cold", "comfort", "commend", "confused", "congratulate",
	"cough", "cower", "crack", "cringe", "cry", "cuddle", "curious",
	"dance", "drink", "drool", "duck", "eat", "eye", "fart",
	"fidget", "flex", "flirt", "flop", "followme", "frown",
	"gasp", "gaze", "giggle", "glare", "gloat", "greet", "grin",
	"groan", "grovel", "guffaw", "hail", "happy", "hello", "hug",
	"hungry", "impatient", "insult", "introduce", "jk", "kiss",
	"kneel", "laugh", "lavish", "lay", "lick", "lie", "listen",
	"lost", "love", "lol", "mad", "moan", "mock", "mourn",
	"no", "nod", "nosepick", "panic", "pat", "peer", "pest",
	"pet", "pinch", "pity", "pizza", "plead", "point", "poke",
	"ponder", "pounce", "praise", "pray", "purr", "puzzle",
	"question", "raise", "rasp", "read", "ready", "rear", "remark",
	"roar", "rofl", "rude", "sad", "salute", "scared", "scratch",
	"sexy", "shake", "shiver", "shoo", "shout", "shrug", "shy",
	"sigh", "silly", "sit", "sleep", "smile", "smirk", "snarl",
	"sneak", "snicker", "sniff", "snub", "soothe", "spit", "stare",
	"strong", "strut", "surprised", "surrender", "sweat", "talk",
	"talkex", "talkq", "tap", "taunt", "tease", "thank", "thirsty",
	"threaten", "tickle", "tired", "tongue", "train", "ty",
	"veto", "victory", "violin", "volunteer", "wait", "wave",
	"welcome", "whine", "whistle", "wicked", "wink", "work",
	"wow", "yawn", "yes"
}

function EmoteManager:New(addon)
	local manager = {}
	setmetatable(manager, { __index = self })
	manager.addon = addon
	return manager
end

function EmoteManager:GetAllEmotes()
	return AVAILABLE_EMOTES
end

function EmoteManager:GetEnabledEmotes()
	local enabled = {}
	local profile = self.addon.db.profile

	for i, emote in ipairs(profile.emotes) do
		if profile.enabledEmotes[i] then
			table.insert(enabled, emote)
		end
	end

	return enabled
end

function EmoteManager:ExecuteEmote(emoteName)
	DoEmote(emoteName)
end

function EmoteManager:AddEmote(emoteName)
	local profile = self.addon.db.profile

	for i, emote in ipairs(profile.emotes) do
		if emote == emoteName then
			profile.enabledEmotes[i] = true
			return
		end
	end

	table.insert(profile.emotes, emoteName)
	profile.enabledEmotes[#profile.emotes] = true
end

function EmoteManager:RemoveEmote(emoteName)
	local profile = self.addon.db.profile

	for i, emote in ipairs(profile.emotes) do
		if emote == emoteName then
			profile.enabledEmotes[i] = false
			return
		end
	end
end

function EmoteManager:IsEmoteEnabled(emoteName)
	local profile = self.addon.db.profile

	for i, emote in ipairs(profile.emotes) do
		if emote == emoteName and profile.enabledEmotes[i] then
			return true
		end
	end

	return false
end
