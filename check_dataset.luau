--!strict

--[[
	check_dataset.luau
	Automated Dataset Linter & Integrity Verification Tool.
	Run via: luau submodules/QuestionsModule/check_dataset.luau
--]]

local TextNormalizer = require("./TextNormalizer")

local questionFiles = {
	"alat_musik_tradisional_indonesia",
	"alat_transportasi_umum",
	"benda_di_dalam_ruang_kelas",
	"buah_asli_tropis",
	"bumbu_dapur_masakan_indonesia",
	"gunung_berapi_di_indonesia",
	"hewan_berkaki_empat",
	"hewan_endemik_indonesia",
	"jajanan_pasar_kue_tradisional",
	"kabupaten_di_indonesia",
	"kota_di_indonesia",
	"lagu_daerah_indonesia",
	"makanan_khas_indonesia",
	"minuman_tradisional_indonesia",
	"nama_ibukota_negara_di_asia",
	"olahraga_populer_dunia",
	"pahlawan_nasional_indonesia",
	"provinsi_di_pulau_jawa",
	"provinsi_indonesia",
	"provinsi_sumatera",
	"senjata_tradisional_nusantara",
	"suku_bangsa_di_indonesia",
	"tarian_tradisional_indonesia",
}

local errors: { string } = {}
local warnings: { string } = {}
local seenIds: { [string]: string } = {}

local totalQuestions = 0
local totalAnswers = 0
local tierCounts = {
	common = 0,    -- 50 - 80
	uncommon = 0,  -- 120 - 250
	rare = 0,      -- 350 - 500
	other = 0,
}

print("🔍 Running Dataset Linter & Quality Check...\n")

for _, filename in questionFiles do
	local filepath = "./Questions/" .. filename
	local ok, q = pcall(require, filepath)

	if not ok or typeof(q) ~= "table" then
		table.insert(errors, string.format("❌ Failed to load module '%s': %s", filepath, tostring(q)))
		continue
	end

	totalQuestions += 1

	-- Check ID
	if not q.id or typeof(q.id) ~= "string" or q.id == "" then
		table.insert(errors, string.format("❌ [%s] Missing or invalid 'id' field.", filename))
	elseif q.id ~= filename then
		table.insert(warnings, string.format("⚠️ [%s] ID '%s' does not match filename '%s'.", filename, q.id, filename))
	end

	if q.id and seenIds[q.id] then
		table.insert(errors, string.format("❌ Duplicate question ID '%s' found in both '%s' and '%s'.", q.id, seenIds[q.id], filename))
	elseif q.id then
		seenIds[q.id] = filename
	end

	-- Check Category & Prompt
	if not q.category or typeof(q.category) ~= "string" or q.category == "" then
		table.insert(errors, string.format("❌ [%s] Missing or invalid 'category' field.", filename))
	end
	if not q.prompt or typeof(q.prompt) ~= "string" or q.prompt == "" then
		table.insert(errors, string.format("❌ [%s] Missing or invalid 'prompt' field.", filename))
	end

	-- Check Answers
	if not q.answers or typeof(q.answers) ~= "table" then
		table.insert(errors, string.format("❌ [%s] Missing or invalid 'answers' table.", filename))
		continue
	end

	local questionAnswerCount = 0
	local seenKeys: { [string]: boolean } = {}

	for key, points in q.answers do
		questionAnswerCount += 1
		totalAnswers += 1

		-- Check Key Normalization
		local cleaned = TextNormalizer.clean(key)
		if key ~= cleaned then
			table.insert(warnings, string.format("⚠️ [%s] Answer key '%s' is not normalized. Should be '%s'.", filename, key, cleaned))
		end

		if seenKeys[cleaned] then
			table.insert(errors, string.format("❌ [%s] Duplicate answer key '%s'.", filename, key))
		end
		seenKeys[cleaned] = true

		-- Check Point Value
		if typeof(points) ~= "number" or points < 50 or points > 500 then
			table.insert(errors, string.format("❌ [%s] Invalid point value for '%s': %s (must be 50-500).", filename, key, tostring(points)))
		elseif points >= 50 and points <= 80 then
			tierCounts.common += 1
		elseif points >= 120 and points <= 250 then
			tierCounts.uncommon += 1
		elseif points >= 350 and points <= 500 then
			tierCounts.rare += 1
		else
			tierCounts.other += 1
		end
	end

	if questionAnswerCount < 10 then
		table.insert(warnings, string.format("⚠️ [%s] Has only %d answers. Recommended minimum is 15+.", filename, questionAnswerCount))
	end
end

-- Print Warnings
if #warnings > 0 then
	print("--- WARNINGS ---")
	for _, w in warnings do
		print(w)
	end
	print("")
end

-- Print Errors
if #errors > 0 then
	print("--- ERRORS ---")
	for _, e in errors do
		print(e)
	end
	print(string.format("\n🚨 Linter finished with %d error(s) and %d warning(s)!\n", #errors, #warnings))
else
	print("✨ All Question Modules Passed Validation with 0 Errors!\n")
end

-- Print Dataset Summary Statistics
print("📊 Dataset Statistics:")
print(string.format("  • Total Questions: %d", totalQuestions))
print(string.format("  • Total Answer Keys: %d", totalAnswers))
print(string.format("  • Average Answers / Question: %.1f", totalQuestions > 0 and (totalAnswers / totalQuestions) or 0))
print(string.format("  • Rarity Tier Distribution:"))
print(string.format("    - Common (50-80 pts):    %d (%.1f%%)", tierCounts.common, (tierCounts.common / totalAnswers) * 100))
print(string.format("    - Uncommon (120-250 pts): %d (%.1f%%)", tierCounts.uncommon, (tierCounts.uncommon / totalAnswers) * 100))
print(string.format("    - Rare (350-500 pts):     %d (%.1f%%)", tierCounts.rare, (tierCounts.rare / totalAnswers) * 100))
