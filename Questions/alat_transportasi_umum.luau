--!strict

return {
	id = "alat_transportasi_umum",
	category = "Pengetahuan Umum",
	prompt = "Sebutkan jenis atau moda transportasi umum di darat, laut, atau udara",
	answers = {
		-- Common / Popular answers (50 - 80 pts / meters)
		["bus"] = 50,
		["kereta"] = 50,
		["kereta api"] = 50,
		["pesawat"] = 50,
		["kapal"] = 50,
		["taksi"] = 50,
		["angkot"] = 60,
		["ojek"] = 60,
		["mrt"] = 70,
		["lrt"] = 70,
		["krl"] = 70,
		["kapal laut"] = 60,
		["transjakarta"] = 70,
		["busway"] = 60,

		-- Uncommon answers (120 - 250 pts / meters)
		["becak"] = 140,
		["bajaj"] = 150,
		["delman"] = 160,
		["monorel"] = 180,
		["feri"] = 180,
		["kapal feri"] = 180,
		["speedboat"] = 200,
		["kereta gantung"] = 220,
		["trem"] = 220,
		["mikrolet"] = 180,
		["dokar"] = 200,
		["helikopter"] = 200,
		["kereta cepat"] = 180,
		["whoosh"] = 200,

		-- Rare / Obscure answers (350 - 500 pts / meters)
		["bentor"] = 350,
		["bemo"] = 380,
		["odong odong"] = 360,
		["klotok"] = 420,
		["kapal klotok"] = 420,
		["getek"] = 400,
		["rakit"] = 380,
		["cidomo"] = 460,
		["funicular"] = 480,
		["hovercraft"] = 480,
		["hydrofoil"] = 500,
		["bendi"] = 450,
	},
}
