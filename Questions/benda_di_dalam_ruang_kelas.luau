--!strict

return {
	id = "benda_di_dalam_ruang_kelas",
	category = "Pengetahuan Umum",
	prompt = "Sebutkan benda-benda yang ada di dalam ruang kelas sekolah",
	answers = {
		-- Common / Popular answers (50 - 80 pts / meters)
		["meja"] = 50,
		["kursi"] = 50,
		["papan tulis"] = 50,
		["buku"] = 50,
		["pensil"] = 50,
		["pulpen"] = 50,
		["penghapus"] = 60,
		["penggaris"] = 60,
		["spidol"] = 70,
		["tas"] = 60,
		["kapur"] = 70,
		["jam dinding"] = 70,
		["tempat sampah"] = 80,

		-- Uncommon answers (120 - 250 pts / meters)
		["proyektor"] = 140,
		["peta"] = 150,
		["globe"] = 160,
		["lemari"] = 160,
		["stapler"] = 180,
		["tipex"] = 180,
		["serutan pensil"] = 200,
		["sapu"] = 160,
		["pengki"] = 220,
		["kalender"] = 180,
		["kemoceng"] = 200,
		["papan absen"] = 240,

		-- Rare / Obscure answers (350 - 500 pts / meters)
		["alat peraga"] = 380,
		["jangka sorong"] = 420,
		["busur derajat"] = 400,
		["denah kelas"] = 450,
		["kotak p3k"] = 380,
		["bel listrik"] = 450,
		["mikroskop"] = 420,
		["tabung reaksi"] = 480,
		["mikrometer sekrup"] = 500,
	},
}
