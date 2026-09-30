# Krillion-Grade Trivia Engine & Content Roadmap 🚀

> **Goal:** Elevate *Tebak Kata Panjat Pinang* to the depth, precision, and content richness of **Krillion.io**, tailored specifically for Indonesian and global trivia.

---

## 🎯 Architecture Pillars

```
┌────────────────────────────────────────────────────────────────────────┐
│                        KRILLION-GRADE SYSTEM                           │
├──────────────────────────┬─────────────────────────────┬───────────────┤
│   1. SMART VALIDATION    │     2. DEEP DATASETS        │ 3. CI / QA    │
│  - Prefix stripping      │   - 50–200+ items / prompt  │ - Dupe checks │
│  - Slang & alias engine  │   - 4-Tier point balance    │ - Linter script│
│  - Spell variation match │   - 30+ prompt categories   │ - Analytics log│
└──────────────────────────┴─────────────────────────────┴───────────────┘
```

---

## 📋 Step-by-Step Progression

### Phase 1: Smart Normalization Engine (The Brain) 🧠
- [ ] **1.1 Prefix & Suffix Normalizer** (`Validator.luau`)
  - Auto-strip optional prefixes so players don't need exact syntax:
    - Titles: `pangeran`, `raden`, `tuanku`, `bung`, `jenderal`, `dr`, `ir`, `ra`, `kapitan`
    - Objects/Food: `tari`, `gunung`, `pulau`, `sungai`, `es`, `kue`, `buah`, `hewan`, `lagu`, `alat musik`
- [ ] **1.2 Slang & Regional Abbreviations Dictionary**
  - City abbreviations: `jkt`, `sby`, `bdg`, `jogja`, `smg`, `mks`, `mdn`
  - Province abbreviations: `jabar`, `jateng`, `jatim`, `sumut`, `sumbar`, `sulsel`, `papbar`
- [ ] **1.3 Indonesian Spelling Variation Matcher**
  - Phonetic / orthographic variations: `telur`/`telor`, `cabai`/`cabe`, `musang`/`musang`, `cokelat`/`coklat`.

---

### Phase 2: Core Dataset Expansion (50–150+ Answers per Category) 📚
Expand all open categories from basic sets to deep Krillion-level datasets:

- [ ] **2.1 Geografi Nusantara & Dunia**
  - [ ] `kota_kabupaten_indonesia.luau` (All 514 official cities and regencies)
  - [ ] `provinsi_indonesia.luau` (All 38 provinces + historical provinces)
  - [ ] `gunung_di_indonesia.luau` (100+ active & non-active peaks)
  - [ ] `danau_dan_sungai_indonesia.luau` (Danau Toba, Kapuas, Bengawan Solo, Mahakam, Sentani, etc.)
  - [ ] `negara_dan_ibukota_dunia.luau` (All 195 UN members + dependent territories)
- [ ] **2.2 Sejarah & Pahlawan**
  - [ ] `pahlawan_nasional_indonesia.luau` (Exhaustive list of all 206 officially declared heroes)
  - [ ] `kerajaan_di_nusantara.luau` (Majapahit, Sriwijaya, Tarumanegara, Kutai, Samudera Pasai, etc.)
  - [ ] `tokoh_proklamasi_kemerdekaan.luau`
- [ ] **2.3 Kuliner & Rempah**
  - [ ] `makanan_khas_indonesia.luau` (150+ regional dishes from Aceh to Papua)
  - [ ] `minuman_tradisional_indonesia.luau` (50+ regional drinks, herbal teas, and jams)
  - [ ] `jajanan_pasar_kue_tradisional.luau` (Onde-onde, klepon, lemper, lapis legit, serabi, etc.)
  - [ ] `jenis_sambal_nusantara.luau` (Sambal terasi, matah, dabu-dabu, roa, bajak, ijo, dll.)
- [ ] **2.4 Seni, Budaya & Bahasa**
  - [ ] `alat_musik_tradisional_indonesia.luau` (70+ regional instruments)
  - [ ] `tarian_tradisional_indonesia.luau` (100+ traditional dances)
  - [ ] `lagu_daerah_indonesia.luau` (60+ regional folk songs)
  - [ ] `suku_bangsa_di_indonesia.luau` (100+ recognized ethnic groups)
  - [ ] `rumah_adat_nusantara.luau` (Tongkonan, Gadang, Joglo, Honai, Sasak, dll.)
- [ ] **2.5 Flora & Fauna**
  - [ ] `hewan_endemik_indonesia.luau` (80+ unique wildlife species)
  - [ ] `buah_buahan_tropis.luau` (75+ tropical fruits and native botanical species)
  - [ ] `burung_di_indonesia.luau` (Cendrawasih, Jalak Bali, Julang Sumba, Elang Jawa, Kakaktua, etc.)
- [ ] **2.6 Pengetahuan Umum & Pop Culture**
  - [ ] `alat_transportasi_umum.luau` (50+ traditional and modern transport modes)
  - [ ] `cabang_olahraga_dunia.luau` (80+ Olympic, traditional, and extreme sports)
  - [ ] `mata_uang_dunia.luau` (100+ fiat & historical currencies)
  - [ ] `merek_produk_lokal_populer.luau` (Indomie, Tolak Angin, Silverqueen, Eiger, Polygon, dll.)

---

### Phase 3: Calibrated Scoring & Tier Balance ⚖️
- [ ] **3.1 4-Tier Rarity Calibration (Pole Climb Meters)**:
  - **Tier 1 (Umum / Surface, 50–80m)**: Top ~10% household names (everyone knows).
  - **Tier 2 (Sedang / Mid, 120–250m)**: ~40% well-known regional answers.
  - **Tier 3 (Langka / Deep, 350–450m)**: ~30% enthusiast / niche trivia.
  - **Tier 4 (Sangat Langka / Abyss, 500m)**: ~20% obscure, local dialect, or academic answers.
- [ ] **3.2 Answer Count Validation**:
  - Minimum 40 answers for medium prompts.
  - Minimum 80–150 answers for large open categories.

---

### Phase 4: Automation, CI & Content Linter 🛠️
- [ ] **4.1 Luau Dataset Linter CLI (`check_dataset.luau` or Python script)**
  - Automated check for duplicate IDs across files.
  - Automated check for duplicate answer keys inside each question.
  - Verification that all answer keys are strictly lowercase and symbol-free.
  - Verification of tier distribution (ensuring questions don't lack Rare/Common answers).
- [ ] **4.2 Unrecognized Input Analytics (Player Feedback Loop)**
  - Server-side logger for unrecognized inputs during matches to discover new valid answers and synonyms submitted by real players.

---

## 📊 Milestones Summary

| Milestone | Target Questions | Answers / Question | Status |
| :--- | :---: | :---: | :---: |
| **M1: MVP Core** | 18 | 20–35 | ✅ Completed |
| **M2: Smart Normalizer** | 18 | 35–50 (+ Prefix Engine) | ⏳ Next |
| **M3: Deep Categories** | 30+ | 60–150 | ⏳ Planned |
| **M4: Krillion-Grade Polish** | 50+ | 100–250 + CI Linter | ⏳ Planned |
