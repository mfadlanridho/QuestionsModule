--!strict

local Types
local isRoblox = pcall(function() return game:GetService("ReplicatedStorage") end)

if isRoblox and script and script:FindFirstChild("Types") then
	Types = require(script.Types)
else
	local ok, t = pcall(require, "./Types")
	if not ok then
		ok, t = pcall(require, "../submodules/QuestionsModule/Types")
	end
	Types = t
end

export type Question = Types.Question
export type AnswerMap = Types.AnswerMap

local questionsById: { [string]: Question } = {}
local allQuestions: { Question } = {}
local questionsByCategory: { [string]: { Question } } = {}

local function register(q: Question)
	if q and q.id and not questionsById[q.id] then
		questionsById[q.id] = q
		table.insert(allQuestions, q)

		local cat = q.category or "Lainnya"
		if not questionsByCategory[cat] then
			questionsByCategory[cat] = {}
		end
		table.insert(questionsByCategory[cat], q)
	end
end

-- In Roblox environment: dynamically load all child ModuleScripts from Questions folder or self
local targetContainer: Instance? = nil
if isRoblox and script and script.FindFirstChild then
	targetContainer = script:FindFirstChild("Questions") or script
end

if targetContainer and targetContainer.GetChildren then
	for _, child in targetContainer:GetChildren() do
		if child:IsA("ModuleScript") and child ~= script and child.Name ~= "Types" and child.Name ~= "Validator" then
			local success, q = pcall(require, child)
			if success and typeof(q) == "table" and (q :: any).id then
				register(q :: Question)
			end
		end
	end
else
	-- Standalone Luau CLI fallback
	local questionFiles = {
		"alat_musik_tradisional_indonesia",
		"alat_transportasi_umum",
		"bandara_dan_pelabuhan_indonesia",
		"benda_di_dalam_ruang_kelas",
		"buah_asli_tropis",
		"bumbu_dapur_masakan_indonesia",
		"danau_dan_sungai_di_indonesia",
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
		"provinsi_indonesia",
		"senjata_tradisional_nusantara",
		"suku_bangsa_di_indonesia",
		"tarian_tradisional_indonesia",
	}

	for _, f in questionFiles do
		local ok, q = pcall(require, "./Questions/" .. f)
		if not ok then
			ok, q = pcall(require, "../submodules/QuestionsModule/Questions/" .. f)
		end
		if ok and typeof(q) == "table" and (q :: any).id then
			register(q :: Question)
		end
	end
end

local QuestionsModule = {}

function QuestionsModule.getAll(): { Question }
	return allQuestions
end

function QuestionsModule.get(id: string): Question?
	return questionsById[id]
end

function QuestionsModule.getByCategory(category: string): { Question }
	return questionsByCategory[category] or {}
end

function QuestionsModule.getCategories(): { string }
	local list = {}
	for cat in questionsByCategory do
		table.insert(list, cat)
	end
	table.sort(list)
	return list
end

function QuestionsModule.getRandom(excludeIds: { [string]: boolean }?): Question?
	local candidates = {}
	for _, q in allQuestions do
		if not excludeIds or not excludeIds[q.id] then
			table.insert(candidates, q)
		end
	end

	if #candidates == 0 then
		if #allQuestions == 0 then return nil end
		return allQuestions[math.random(1, #allQuestions)]
	end

	return candidates[math.random(1, #candidates)]
end

function QuestionsModule.count(): number
	return #allQuestions
end

return QuestionsModule
