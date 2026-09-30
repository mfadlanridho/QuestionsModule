# QuestionsModule (Tebak Kata Trivia Dataset)

Standalone trivia dataset module for *Tebak Kata Panjat Pinang*.

---

## 📁 Structure

```
QuestionsModule/
├── init.luau             -- Dynamic loader & query methods
├── Types.luau            -- Strict Luau type definitions
├── README.md             -- Documentation
└── Questions/            -- Individual question modules
    ├── alat_musik_tradisional_indonesia.luau
    ├── provinsi_di_pulau_jawa.luau
    └── ...
```

---

## 📝 Adding a New Question

Create a new file `Questions/<question_id>.luau`:

```lua
--!strict

return {
	id = "<unique_snake_case_id>",
	category = "<Kategori (e.g. Geografi, Kuliner, Fauna, Pop Culture, Budaya, Pengetahuan Umum)>",
	prompt = "<Pertanyaan dalam Bahasa Indonesia yang jelas>",
	answers = {
		-- Common / Popular answers (50 - 80 pts / meters)
		["jawaban umum 1"] = 50,
		["jawaban umum 2"] = 50,

		-- Uncommon answers (120 - 250 pts / meters)
		["jawaban sedang 1"] = 150,
		["jawaban sedang 2"] = 200,

		-- Rare / Obscure answers (350 - 500 pts / meters)
		["jawaban langka 1"] = 400,
		["jawaban sangat langka 2"] = 500,
	},
}
```

### Answer Key Rules:
- Keys must be in lowercase.
- Letters, numbers, and single spaces only (no hyphens, apostrophes, or punctuation).
- Synonyms or common alternative spellings can be included as separate keys.

---

## 🚀 API Reference

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local QuestionsModule = require(ReplicatedStorage.Submodules.QuestionsModule)

-- Get all loaded questions
local all = QuestionsModule.getAll()

-- Find a question by ID
local q = QuestionsModule.get("provinsi_di_pulau_jawa")

-- Get questions in a category
local geoList = QuestionsModule.getByCategory("Geografi")

-- Get a random question (with optional exclusion table)
local randomQ = QuestionsModule.getRandom({ ["provinsi_di_pulau_jawa"] = true })

-- Total count
local total = QuestionsModule.count()
```
