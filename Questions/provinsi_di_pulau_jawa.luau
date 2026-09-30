--!strict

return {
	id = "provinsi_di_pulau_jawa",
	category = "Geografi",
	prompt = "Sebutkan nama provinsi atau daerah khusus di Pulau Jawa",
	answers = {
		-- Common / Popular answers (50 - 80 pts / meters)
		["dki jakarta"] = 50,
		["jakarta"] = 50,
		["jawa barat"] = 50,
		["jawa tengah"] = 50,
		["jawa timur"] = 50,
		["jabar"] = 70,
		["jateng"] = 70,
		["jatim"] = 70,

		-- Uncommon answers (120 - 250 pts / meters)
		["banten"] = 140,
		["di yogyakarta"] = 160,
		["yogyakarta"] = 150,
		["jogja"] = 150,
		["jogjakarta"] = 160,

		-- Rare / Obscure answers (350 - 500 pts / meters)
		["daerah istimewa yogyakarta"] = 380,
		["daerah khusus ibukota jakarta"] = 420,
	},
}
