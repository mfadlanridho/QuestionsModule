--!strict

--[[
	TextNormalizer.luau
	Smart Normalization & Fuzzy-Matching Engine for Indonesian Trivia.
	
	Handles:
	- Whitespace & symbol cleansing
	- Slang & regional abbreviation expansion (e.g., "jkt" -> "jakarta", "jogja" -> "yogyakarta")
	- Indonesian prefix / title stripping (e.g., "tari saman" -> "saman", "pangeran diponegoro" -> "diponegoro")
	- Common Indonesian spelling variants (e.g., "telor" -> "telur", "cabe" -> "cabai")
	- 1-character typo tolerance (Levenshtein distance <= 1 for words length >= 5)
--]]

local PREFIXES = {
	-- Category nouns
	"alat musik ",
	"alat ",
	"tarian ",
	"tari ",
	"gunung ",
	"pulau ",
	"kepulauan ",
	"sungai ",
	"danau ",
	"selat ",
	"es ",
	"kue ",
	"buah ",
	"hewan ",
	"burung ",
	"ikan ",
	"lagu ",
	"senjata ",
	"rumah ",
	"suku ",
	"kabupaten ",
	"kota ",
	"provinsi ",
	"negara ",

	-- Titles and honorifics
	"raden ajeng ",
	"raden ayu ",
	"raden ",
	"pangeran ",
	"tuanku ",
	"jenderal ",
	"jendral ",
	"kapitan ",
	"sultan ",
	"ki hajar ",
	"bung ",
	"teuku ",
	"cut ",
	"nyai ",
	"kyai ",
	"ir ",
	"dr ",
	"ra ",
	"wr ",
}

local SLANG_AND_ABBREVIATIONS: { [string]: string } = {
	["jkt"] = "jakarta",
	["dki jakarta"] = "jakarta",
	["sby"] = "surabaya",
	["bdg"] = "bandung",
	["jogja"] = "yogyakarta",
	["yogya"] = "yogyakarta",
	["jogjakarta"] = "yogyakarta",
	["smg"] = "semarang",
	["mks"] = "makassar",
	["mdn"] = "medan",
	["jabar"] = "jawa barat",
	["jateng"] = "jawa tengah",
	["jatim"] = "jawa timur",
	["sumut"] = "sumatera utara",
	["sumbar"] = "sumatera barat",
	["sumsel"] = "sumatera selatan",
	["sulsel"] = "sulawesi selatan",
	["sulteng"] = "sulawesi tengah",
	["sultra"] = "sulawesi tenggara",
	["sulut"] = "sulawesi utara",
	["kalsel"] = "kalimantan selatan",
	["kaltim"] = "kalimantan timur",
	["kalbar"] = "kalimantan barat",
	["kalteng"] = "kalimantan tengah",
	["papbar"] = "papua barat",
	["ntt"] = "nusa tenggara timur",
	["ntb"] = "nusa tenggara barat",
	["babel"] = "bangka belitung",
	["kepri"] = "kepulauan riau",
}

local SPELLING_VARIANTS: { [string]: string } = {
	["telor"] = "telur",
	["cabe"] = "cabai",
	["coklat"] = "cokelat",
	["kaos"] = "kaus",
	["antri"] = "antre",
	["bis"] = "bus",
	["praktek"] = "praktik",
	["apotik"] = "apotek",
	["ijasah"] = "ijazah",
	["kasiat"] = "khasiat",
	["karambit"] = "kerambit",
	["clurit"] = "celurit",
	["sereh"] = "serai",
	["laos"] = "lengkuas",
	["sepakbola"] = "sepak bola",
	["bulutangkis"] = "bulu tangkis",
}

local TextNormalizer = {}

-- Fast Levenshtein distance (optimized for short strings)
function TextNormalizer.levenshteinDistance(s1: string, s2: string): number
	local len1 = #s1
	local len2 = #s2

	if len1 == 0 then return len2 end
	if len2 == 0 then return len1 end
	if math.abs(len1 - len2) > 1 then return math.abs(len1 - len2) end

	local matrix = {}
	for i = 0, len1 do
		matrix[i] = { [0] = i }
	end
	for j = 0, len2 do
		matrix[0][j] = j
	end

	for i = 1, len1 do
		local b1 = string.byte(s1, i)
		for j = 1, len2 do
			local b2 = string.byte(s2, j)
			local cost = (b1 == b2) and 0 or 1
			local del = matrix[i - 1][j] + 1
			local ins = matrix[i][j - 1] + 1
			local sub = matrix[i - 1][j - 1] + cost
			local min = del
			if ins < min then min = ins end
			if sub < min then min = sub end
			matrix[i][j] = min
		end
	end

	return matrix[len1][len2]
end

-- Basic normalization: lowercasing, symbols -> spaces, whitespace collapsing
function TextNormalizer.clean(input: string?): string
	if not input or typeof(input) ~= "string" then
		return ""
	end

	local cleaned = string.lower(input)
	cleaned = string.gsub(cleaned, "[^%w%s]", " ")
	cleaned = string.gsub(cleaned, "%s+", " ")
	cleaned = string.gsub(cleaned, "^%s+", "")
	cleaned = string.gsub(cleaned, "%s+$", "")

	return cleaned
end

-- Generate a set of candidate variants for matching
function TextNormalizer.getCandidates(normalized: string): { string }
	local candidates = { normalized }
	local seen: { [string]: boolean } = { [normalized] = true }

	local function addCandidate(variant: string)
		if variant ~= "" and not seen[variant] then
			seen[variant] = true
			table.insert(candidates, variant)
		end
	end

	-- 1. Check slang / abbreviation
	local slangMatch = SLANG_AND_ABBREVIATIONS[normalized]
	if slangMatch then
		addCandidate(slangMatch)
	end

	-- 2. Check spelling variants
	local spellingMatch = SPELLING_VARIANTS[normalized]
	if spellingMatch then
		addCandidate(spellingMatch)
	end

	-- 3. Check stripped prefix
	for _, prefix in PREFIXES do
		if string.sub(normalized, 1, #prefix) == prefix then
			local stripped = string.sub(normalized, #prefix + 1)
			addCandidate(stripped)

			-- Also check slang/spelling on stripped version
			if SLANG_AND_ABBREVIATIONS[stripped] then
				addCandidate(SLANG_AND_ABBREVIATIONS[stripped])
			end
			if SPELLING_VARIANTS[stripped] then
				addCandidate(SPELLING_VARIANTS[stripped])
			end
		end
	end

	return candidates
end

-- Smart match player input against question answer map
-- Returns: matchedKey, score (or nil, 0)
function TextNormalizer.matchAnswer(
	rawInput: string,
	answers: { [string]: number },
	enableTypoTolerance: boolean?
): (string?, number)
	local cleaned = TextNormalizer.clean(rawInput)
	if cleaned == "" then
		return nil, 0
	end

	-- Pass 1: Direct candidates match
	local candidates = TextNormalizer.getCandidates(cleaned)
	for _, candidate in candidates do
		local score = answers[candidate]
		if score then
			return candidate, score
		end
	end

	-- Pass 2: Reverse prefix match (e.g., answer table has "tari saman", player typed "saman")
	for _, prefix in PREFIXES do
		local prefixed = prefix .. cleaned
		local score = answers[prefixed]
		if score then
			return prefixed, score
		end
	end

	-- Pass 3: 1-Letter Typo tolerance (Levenshtein distance <= 1 for words length >= 5)
	if enableTypoTolerance ~= false and #cleaned >= 5 then
		for key, score in answers do
			if #key >= 4 and math.abs(#key - #cleaned) <= 1 then
				local dist = TextNormalizer.levenshteinDistance(cleaned, key)
				if dist <= 1 then
					return key, score
				end
			end
		end
	end

	return nil, 0
end

return TextNormalizer
