--!strict

return {
	id = "olahraga_populer_dunia",
	category = "Pop Culture",
	prompt = "Sebutkan cabang olahraga yang populer di dunia",
	answers = {
		-- Common / Popular answers (50 - 80 pts / meters)
		["sepak bola"] = 50,
		["sepakbola"] = 50,
		["badminton"] = 50,
		["bulu tangkis"] = 50,
		["bulutangkis"] = 50,
		["basket"] = 50,
		["bola basket"] = 50,
		["voli"] = 60,
		["bola voli"] = 60,
		["renang"] = 60,
		["lari"] = 70,
		["futsal"] = 70,
		["tenis"] = 70,
		["tinju"] = 80,

		-- Uncommon answers (120 - 250 pts / meters)
		["tenis meja"] = 140,
		["pingpong"] = 140,
		["catur"] = 150,
		["golf"] = 160,
		["senam"] = 160,
		["taekwondo"] = 180,
		["karate"] = 180,
		["pencak silat"] = 180,
		["silat"] = 180,
		["panahan"] = 200,
		["sepak takraw"] = 220,
		["baseball"] = 200,
		["rugby"] = 220,
		["kriket"] = 250,

		-- Rare / Obscure answers (350 - 500 pts / meters)
		["curling"] = 380,
		["polo air"] = 400,
		["kayak"] = 420,
		["dayung"] = 350,
		["anggar"] = 380,
		["bobsleigh"] = 450,
		["biathlon"] = 480,
		["padel"] = 420,
		["kabaddi"] = 500,
		["squash"] = 450,
		["lacrosse"] = 500,
	},
}
