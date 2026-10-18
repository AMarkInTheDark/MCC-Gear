-- MCC Gear: Escape from Tarkov's chest rigs and backpacks for the MCC inventory (needs MCC Base).
--
-- The models are PLACEHOLDERS: every rig and backpack works in the inventory already (its pockets, size, weight, slot),
-- but uses a stand-in HL2 prop and isn't drawn on the player yet. When a real model is ready, fill in its two
-- lines in RIGS below and restart:
--
--   model = "models/.../rig_world.mdl",  -- what it looks like on the ground and in the inventory
--   worn  = "models/.../rig_worn.mdl",   -- rigged to the player skeleton (bonemerged onto the character)
--
-- Or without touching Lua, in the console (saved to data/mcc/items.json):
--   mcc_item_set rig_scav_vest model models/.../rig_world.mdl
--   mcc_item_set rig_scav_vest data.worn models/.../rig_worn.mdl
-- `mcc_gear_missing` lists the gear still waiting for models (backpacks the same way: bp_* ids).
--
-- Pocket layouts: each cell is a grid {x, y, w, h} in inventory squares; the .1 offsets are the gaps
-- between pockets, matching each rig's layout in Tarkov.

AddCSLuaFile()

MCC_GEAR = MCC_GEAR or {}
MCC_GEAR.VERSION = "0.6.0"

-- Stand-in HL2 props until the real models are in ("placeholder" per rig; this one otherwise).
local PLACEHOLDER = "models/props_c17/BriefCase001a.mdl"

-- id -> definition, from Escape from Tarkov (size, weight, pocket layout). "worn" and a real "model" are
-- what's missing for each ("placeholder" is the HL2 prop shown meanwhile). Size is w x h squares.
local RIGS = {
    rig_scav_vest = {
        name = "Scav Vest", short = "Scav Vest", w = 2, h = 3, weight = 0.4, price = 200, rarity = "common",
        desc = "A worn hunting vest with simple pockets. 6 slots.",
        placeholder = "models/props_junk/garbage_bag001a.mdl", model = nil, worn = nil,
        cells = { -- 1x1, 1x2, 1x2, 1x1 side by side
            {x = 0, y = 0, w = 1, h = 1}, {x = 1.1, y = 0, w = 1, h = 2},
            {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 1},
        },
    },
    rig_security_vest = {
        name = "Security vest", short = "Security vest", w = 2, h = 3, weight = 0.51, price = 250, rarity = "common",
        desc = "The simplest, life-worn vest of the security services. 6 slots.",
        placeholder = "models/props_c17/BriefCase001a.mdl", model = nil, worn = nil,
        cells = { -- same pockets as the Scav Vest
            {x = 0, y = 0, w = 1, h = 1}, {x = 1.1, y = 0, w = 1, h = 2},
            {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 1},
        },
    },
    rig_m4_rscr = {
        name = "Zulu Nylon Gear M4 Reduced Signature Chest Rig (Ranger Green)", short = "M4 RSCR", w = 2, h = 3, weight = 0.521, price = 450,
        rarity = "uncommon",
        desc = "A lightweight, minimalist chest rig for carrying just the essentials: three magazine pouches. 6 slots.",
        placeholder = "models/items/boxmrounds.mdl", model = nil, worn = nil,
        cells = { -- three 1x2 magazine pouches
            {x = 0, y = 0, w = 1, h = 2}, {x = 1.1, y = 0, w = 1, h = 2}, {x = 2.2, y = 0, w = 1, h = 2},
        },
    },
    rig_idea = {
        name = "DIY IDEA chest rig", short = "IDEA Rig", w = 2, h = 3, weight = 0.22, price = 300, rarity = "common",
        desc = "A homemade chest rig sewn from a shopping bag: four pouches. 8 slots.",
        placeholder = "models/props_junk/garbage_bag001a.mdl", model = nil, worn = nil,
        cells = { -- four 1x2 pouches
            {x = 0, y = 0, w = 1, h = 2}, {x = 1.1, y = 0, w = 1, h = 2},
            {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 2},
        },
    },
    rig_bank_robber_black = {
        name = "Spiritus Systems Bank Robber chest rig (MultiCam Black)", short = "Bank Robber", w = 2, h = 3, weight = 0.7,
        price = 600, rarity = "uncommon",
        desc = "A slim chest rig with four magazine pouches. 8 slots.",
        placeholder = "models/items/boxmrounds.mdl", model = nil, worn = nil,
        cells = { -- four 1x2 magazine pouches
            {x = 0, y = 0, w = 1, h = 2}, {x = 1.1, y = 0, w = 1, h = 2},
            {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 2},
        },
    },
    rig_bank_robber_alpine = {
        name = "Spiritus Systems Bank Robber chest rig (MultiCam Alpine)", short = "Bank Robber (Alpine)", w = 2, h = 3, weight = 0.7,
        price = 600, rarity = "uncommon",
        desc = "The Bank Robber in a snow camouflage: four magazine pouches. 8 slots.",
        placeholder = "models/items/boxmrounds.mdl", model = nil, worn = nil,
        cells = { -- same pouches as the MultiCam Black one
            {x = 0, y = 0, w = 1, h = 2}, {x = 1.1, y = 0, w = 1, h = 2},
            {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 2},
        },
    },
    rig_soe_micro = {
        name = "SOE Micro Rig (MultiCam)", short = "Micro Rig", w = 2, h = 3, weight = 0.8, price = 700, rarity = "uncommon",
        desc = "A compact rig: one large utility pouch and two magazine pouches. 8 slots.",
        placeholder = "models/items/boxsrounds.mdl", model = nil, worn = nil,
        cells = { -- a 2x2 pouch, then two 1x2
            {x = 0, y = 0, w = 2, h = 2}, {x = 2.1, y = 0, w = 1, h = 2}, {x = 3.2, y = 0, w = 1, h = 2},
        },
    },
    rig_type56 = {
        name = "Type 56 Chicom chest harness", short = "Type 56 Chicom", w = 3, h = 3, weight = 0.65, price = 550, rarity = "common",
        desc = "An old Chinese chest harness: three long magazine pouches between two pairs of small ones. 10 slots.",
        placeholder = "models/props_junk/garbage_bag001a.mdl", model = nil, worn = nil,
        cells = { -- two 1x1 stacked, three 1x2, two 1x1 stacked
            {x = 0, y = 0, w = 1, h = 1}, {x = 0, y = 1.1, w = 1, h = 1},
            {x = 1.1, y = 0, w = 1, h = 2}, {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 2},
            {x = 4.4, y = 0, w = 1, h = 1}, {x = 4.4, y = 1.1, w = 1, h = 1},
        },
    },
    -- rigs that share a layout (and colour variants) are added below, from LAYOUTS
    rig_wartech_tv109 = {
        name = "WARTECH TV-109 + TV-106 chest rig (A-TACS FG)", short = "WTRig", w = 3, h = 3, weight = 1.8, price = 900,
        rarity = "uncommon",
        desc = "A heavy chest rig: a large utility pouch, two magazine pouches and two small ones. 10 slots.",
        placeholder = "models/items/ammocrate_smg1.mdl", model = nil, worn = nil,
        cells = { -- a 2x2, two 1x2, two 1x1 stacked
            {x = 0, y = 0, w = 2, h = 2}, {x = 2.1, y = 0, w = 1, h = 2}, {x = 3.2, y = 0, w = 1, h = 2},
            {x = 4.3, y = 0, w = 1, h = 1}, {x = 4.3, y = 1.1, w = 1, h = 1},
        },
    },
    rig_csa_black = {
        name = "CSA chest rig (Black)", short = "CSA", w = 2, h = 3, weight = 0.75, price = 650, rarity = "uncommon",
        desc = "A light chest rig with two long pouches either side of two magazine pouches. 10 slots.",
        placeholder = "models/props_c17/BriefCase001a.mdl", model = nil, worn = nil,
        cells = { -- 1x3, 1x2, 1x2, 1x3
            {x = 0, y = 0, w = 1, h = 3}, {x = 1.1, y = 0, w = 1, h = 2},
            {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 3},
        },
    },
    rig_6sh112 = {
        name = "UMTBS 6Sh112 Scout-Sniper chest rig (EMR)", short = "6Sh112 S-S", w = 3, h = 4, weight = 1.7, price = 1100,
        rarity = "rare",
        desc = "A Russian army scout-sniper rig: four magazine pouches over four small ones. 12 slots.",
        placeholder = "models/items/ammocrate_ar2.mdl", model = nil, worn = nil,
        cells = { -- four 1x2 on top, four 1x1 below
            {x = 0, y = 0, w = 1, h = 2}, {x = 1.1, y = 0, w = 1, h = 2}, {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 2},
            {x = 0, y = 2.1, w = 1, h = 1}, {x = 1.1, y = 2.1, w = 1, h = 1}, {x = 2.2, y = 2.1, w = 1, h = 1}, {x = 3.3, y = 2.1, w = 1, h = 1},
        },
    },
    rig_khamelion = {
        name = "Azimut SS \"Khamelion\" chest harness (Olive)", short = "Khamelion", w = 3, h = 4, weight = 1.7, price = 1100,
        rarity = "rare",
        desc = "A chest harness with four magazine pouches over four small ones. 12 slots.",
        placeholder = "models/items/ammocrate_ar2.mdl", model = nil, worn = nil,
        cells = { -- four 1x2 on top, four 1x1 below (as the 6Sh112)
            {x = 0, y = 0, w = 1, h = 2}, {x = 1.1, y = 0, w = 1, h = 2}, {x = 2.2, y = 0, w = 1, h = 2}, {x = 3.3, y = 0, w = 1, h = 2},
            {x = 0, y = 2.1, w = 1, h = 1}, {x = 1.1, y = 2.1, w = 1, h = 1}, {x = 2.2, y = 2.1, w = 1, h = 1}, {x = 3.3, y = 2.1, w = 1, h = 1},
        },
    },
}

-- Pocket layouts several rigs share. 1x2 pouches stand in a row of four (x = 0, 1.1, 2.2, 3.3); rows below
-- start at y = 2.1, and 1x1 pockets stacked in a column at y = 2.1 and 3.2.
local function Row4(y, h) -- four pouches side by side, h tall
    local out = {}
    for i = 0, 3 do out[#out + 1] = {x = i * 1.1, y = y, w = 1, h = h} end
    return out
end
local function Join(...)
    local out = {}
    for _, list in ipairs({...}) do
        for _, c in ipairs(list) do out[#out + 1] = c end
    end
    return out
end
local SMALL_STACK = function(x) return {{x = x, y = 2.1, w = 1, h = 1}, {x = x, y = 3.2, w = 1, h = 1}} end
local LAYOUTS = {
    -- four 1x2 over four 1x2 (16 slots)
    two_rows = function() return Join(Row4(0, 2), Row4(2.1, 2)) end,
    -- four 1x2 over four 1x1, then a 1x1 at each end (14 slots)
    tarzan = function() return Join(Row4(0, 2), Row4(2.1, 1), {{x = 0, y = 3.2, w = 1, h = 1}, {x = 3.3, y = 3.2, w = 1, h = 1}}) end,
    -- four 1x2 over 1x2, 1x2, two 1x1 stacked, 1x2 (16 slots)
    thunderbolt = function()
        return Join(Row4(0, 2), {{x = 0, y = 2.1, w = 1, h = 2}, {x = 1.1, y = 2.1, w = 1, h = 2}}, SMALL_STACK(2.2),
            {{x = 3.3, y = 2.1, w = 1, h = 2}})
    end,
    -- four 1x2 over 1x2, two 1x1 stacked, two 1x1 stacked, 1x2 (16 slots)
    d3crx = function()
        return Join(Row4(0, 2), {{x = 0, y = 2.1, w = 1, h = 2}}, SMALL_STACK(1.1), SMALL_STACK(2.2), {{x = 3.3, y = 2.1, w = 1, h = 2}})
    end,
    -- the same, plus a 2x1 underneath in the middle (18 slots)
    d3crx_18 = function()
        return Join(Row4(0, 2), {{x = 0, y = 2.1, w = 1, h = 2}}, SMALL_STACK(1.1), SMALL_STACK(2.2), {{x = 3.3, y = 2.1, w = 1, h = 2}},
            {{x = 1.1, y = 4.3, w = 2, h = 1}})
    end,
    -- four 1x2 over two 1x1 stacked, two 1x1 stacked, a 2x2 (16 slots)
    umka = function() return Join(Row4(0, 2), SMALL_STACK(0), SMALL_STACK(1.1), {{x = 2.2, y = 2.1, w = 2, h = 2}}) end,
    -- two 2x2 over four 1x2, then two 1x1 in the middle (18 slots)
    lbcr = function()
        return Join({{x = 0, y = 0, w = 2, h = 2}, {x = 2.2, y = 0, w = 2, h = 2}}, Row4(2.1, 2),
            {{x = 1.1, y = 4.2, w = 1, h = 1}, {x = 2.2, y = 4.2, w = 1, h = 1}})
    end,
}
MCC_GEAR.LAYOUTS = LAYOUTS

-- id, name, short, w, h, weight, price, rarity, layout, placeholder, description
local MORE_RIGS = {
    {"rig_tarzan_m22", "Splav Tarzan M22 chest rig (Smog)", "Tarzan", 3, 4, 1.45, 1000, "uncommon", "tarzan",
        "models/props_junk/garbage_bag001a.mdl", "A Russian assault vest in Smog camouflage. 14 slots."},
    {"rig_triton_m43a", "Dynaforce Triton M43-A chest harness (Black)", "Triton", 3, 4, 1.3, 1500, "rare", "two_rows",
        "models/props_c17/BriefCase001a.mdl", "A chest harness with two rows of four magazine pouches. 16 slots."},
    {"rig_commando_black", "BlackHawk! Commando chest harness (Black)", "Commando", 3, 4, 1.35, 1400, "rare", "two_rows",
        "models/items/boxmrounds.mdl", "A chest harness with two rows of four magazine pouches. 16 slots."},
    {"rig_commando_tan", "BlackHawk! Commando chest harness (Desert Tan)", "Commando (Tan)", 3, 4, 1.35, 1400, "rare", "two_rows",
        "models/items/boxmrounds.mdl", "The Commando harness in Desert Tan. 16 slots."},
    {"rig_thunderbolt_grey", "Direct Action Thunderbolt compact chest rig (Shadow Grey)", "Thunderbolt", 3, 3, 0.62, 1600, "rare",
        "thunderbolt", "models/items/boxsrounds.mdl", "A light, compact chest rig with plenty of pouches. 16 slots."},
    {"rig_thunderbolt_green", "Direct Action Thunderbolt compact chest rig (Ranger Green)", "Thunderbolt (Green)", 3, 3, 0.62, 1600,
        "rare", "thunderbolt", "models/items/boxsrounds.mdl", "The Thunderbolt in Ranger Green. 16 slots."},
    {"rig_thunderbolt_wildwood", "Direct Action Thunderbolt compact chest rig (PenCott WildWood)", "Thunderbolt (WildWood)", 3, 3, 0.62,
        1600, "rare", "thunderbolt", "models/items/boxsrounds.mdl", "The Thunderbolt in PenCott WildWood. 16 slots."},
    {"rig_bss_mk1", "Gear Craft GC-BSS-MK1 chest rig (A-TACS FG)", "BSS-MK1", 3, 3, 1.0, 1700, "rare", "d3crx",
        "models/items/ammocrate_smg1.mdl", "A modular chest rig: magazine pouches over small utility pockets. 16 slots."},
    {"rig_umka_m33", "Umka M33-SET1 hunter vest (Olive Drab)", "Umka", 3, 4, 1.2, 1300, "uncommon", "umka",
        "models/props_junk/garbage_bag001a.mdl", "A hunting vest with magazine pouches, small pockets and a large pouch. 16 slots."},
    {"rig_d3crx_green", "Haley Strategic D3CRX Chest Harness (Ranger Green)", "D3CRX", 3, 3, 0.9, 2200, "rare", "d3crx",
        "models/items/ammocrate_ar2.mdl", "A light, modular chest harness. 16 slots."},
    {"rig_d3crx_black", "Haley Strategic D3CRX Chest Harness (Black)", "D3CRX (Black)", 3, 3, 0.9, 2200, "rare", "d3crx",
        "models/items/ammocrate_ar2.mdl", "The D3CRX in black. 16 slots."},
    {"rig_d3crx_coyote", "Haley Strategic D3CRX Chest Harness (Coyote Brown)", "D3CRX (Coyote)", 3, 3, 0.9, 2600, "epic", "d3crx_18",
        "models/items/ammocrate_ar2.mdl", "The D3CRX with an extra pouch underneath. 18 slots."},
    {"rig_d3crx_multicam", "Haley Strategic D3CRX Chest Harness (MultiCam)", "D3CRX (MultiCam)", 3, 3, 0.9, 2600, "epic", "d3crx_18",
        "models/items/ammocrate_ar2.mdl", "The D3CRX in MultiCam, with an extra pouch underneath. 18 slots."},
    {"rig_lbcr_grey", "LBT-1961A Load Bearing Chest Rig (MAS Grey)", "LBCR", 3, 3, 1.36, 3000, "epic", "lbcr",
        "models/items/ammocrate_smg1.mdl", "A roomy load-bearing chest rig: two large pouches over four magazine pouches. 18 slots."},
    {"rig_lbcr_goons", "LBT-1961A Load Bearing Chest Rig (Goons Edition)", "LBCR GE", 3, 3, 1.36, 3200, "epic", "lbcr",
        "models/items/ammocrate_smg1.mdl", "The LBCR as the Goons wear it. 18 slots."},
    {"rig_lbcr_aor1", "LBT-1961A Load Bearing Chest Rig (AOR1)", "LBCR (AOR1)", 3, 3, 1.36, 3000, "epic", "lbcr",
        "models/items/ammocrate_smg1.mdl", "The LBCR in AOR1. 18 slots."},
    {"rig_lbcr_multicam", "LBT-1961A Load Bearing Chest Rig (MultiCam)", "LBCR (MultiCam)", 3, 3, 1.36, 3000, "epic", "lbcr",
        "models/items/ammocrate_smg1.mdl", "The LBCR in MultiCam. 18 slots."},
    {"rig_lbcr_dnc", "LBT-1961A Load Bearing Chest Rig (DNC)", "LBCR (DNC)", 3, 3, 1.36, 3000, "epic", "lbcr",
        "models/items/ammocrate_smg1.mdl", "The LBCR in DNC. 18 slots."},
}
for _, r in ipairs(MORE_RIGS) do
    RIGS[r[1]] = {name = r[2], short = r[3], w = r[4], h = r[5], weight = r[6], price = r[7], rarity = r[8],
        cells = LAYOUTS[r[9]](), placeholder = r[10], desc = r[11], model = nil, worn = nil}
end
MCC_GEAR.RIGS = RIGS
MCC_GEAR.PLACEHOLDER = PLACEHOLDER

-- Backpacks, from Escape from Tarkov (outer size, weight, inside grid). Tarkov's move speed, turn speed
-- and ergonomics penalties are kept in data for when MCC has movement effects; they do nothing yet.
local BACKPACKS = {
    bp_sling_khaki = {
        name = "Tactical sling bag (Khaki)", short = "Sling", w = 3, h = 3, weight = 0.48, price = 3500, rarity = "common",
        desc = "A one-strap tactical sling bag with MOLLE webbing. 6 slots.",
        stats = {move = 0, turn = 0, ergonomics = -2},
        placeholder = "models/props_c17/suitcase_passenger_physics.mdl", model = nil, worn = nil,
        cells = {{x = 0, y = 0, w = 2, h = 3}},
    },
    bp_vkbo = {
        name = "VKBO army bag", short = "VKBO", w = 3, h = 4, weight = 0.96, price = 5000, rarity = "common",
        desc = "A Russian army bag from the all-season basic equipment kit (VKBO), for soldiers' personal items. 8 slots.",
        stats = {move = -1, turn = 0, ergonomics = -1},
        placeholder = "models/props_junk/garbage_bag001a.mdl", model = nil, worn = nil,
        cells = {{x = 0, y = 0, w = 2, h = 4}},
    },
    bp_tbag = {
        name = "Transformer Bag", short = "T-Bag", w = 3, h = 3, weight = 0.84, price = 7000, rarity = "common",
        desc = "A compact tactical bag that can be carried as a backpack or a sling. 9 slots.",
        stats = {move = 0, turn = 0, ergonomics = -2},
        placeholder = "models/props_c17/SuitCase001a.mdl", model = nil, worn = nil,
        cells = {{x = 0, y = 0, w = 3, h = 3}},
    },
}
MCC_GEAR.BACKPACKS = BACKPACKS

-- Every piece of gear: id -> {def, slot, category, menu category}.
MCC_GEAR.ALL = {}
for id, r in pairs(RIGS) do MCC_GEAR.ALL[id] = {def = r, slot = "rig", category = "rigs", menu = "MCC Equipment - Rigs"} end
for id, b in pairs(BACKPACKS) do
    MCC_GEAR.ALL[id] = {def = b, slot = "backpack", category = "backpacks", menu = "MCC Equipment - Backpacks"}
end

-- Whether a rig still needs its models (as registered, or as changed with mcc_item_set).
function MCC_GEAR.Missing(id)
    local def = MCC and MCC.Items and MCC.Items.Get(id)
    if not def then return nil end
    local out = {}
    local g = MCC_GEAR.ALL[id]
    local stand = g and g.def.placeholder or PLACEHOLDER
    if not def.model or def.model == stand or def.model == PLACEHOLDER then out[#out + 1] = "model" end
    if not def.data or not def.data.worn then out[#out + 1] = "worn" end
    return out
end

-- Spawn menu: Entities > MCC Equipment - Rigs / Backpacks. Each entry drops the item in the world as an
-- MCC item (E to pick it up), the same way MCC Base's magazine entries work.
MCC_GEAR.CATEGORY_RIGS = "MCC Equipment - Rigs"
MCC_GEAR.CATEGORY_BACKPACKS = "MCC Equipment - Backpacks"
if scripted_ents and scripted_ents.Register then
    for id, g in pairs(MCC_GEAR.ALL) do
        local r = g.def
        local ENT = {Type = "anim", Base = "base_anim", PrintName = r.short or r.name, Category = g.menu,
            Spawnable = true, AdminOnly = false, MCCItemID = id}
        function ENT:SpawnFunction(ply, tr)
            if MCC and MCC.Inv and MCC.Inv.SpawnFromMenu then return MCC.Inv.SpawnFromMenu(self.MCCItemID, ply, tr) end
        end
        scripted_ents.Register(ENT, "mcc_gear_" .. id)
    end
end

hook.Add("MCC_RegisterItems", "MCC_Gear", function(Items)
    for id, g in pairs(MCC_GEAR.ALL) do
        local r = g.def
        local data = {slot = g.slot, cells = r.cells, desc = r.desc, stats = r.stats}
        if r.worn then data.worn = r.worn end
        Items.Register(id, {
            name = r.name, kind = "gear", w = r.w, h = r.h, weight = r.weight, price = r.price, rarity = r.rarity,
            model = r.model or r.placeholder or PLACEHOLDER, category = g.category, tags = {g.slot, "mcc_gear", "placeholder"}, data = data,
        })
    end
end)

if SERVER then
    hook.Add("MCC_Loaded", "MCC_Gear", function(MCC)
        MCC.Command("gear_missing", "MCC Moderator", "", "Lists MCC Gear rigs and backpacks still waiting for their models.", function(ply)
            local ids = {}
            for id in pairs(MCC_GEAR.ALL) do ids[#ids + 1] = id end
            table.sort(ids)
            local n = 0
            for _, id in ipairs(ids) do
                local miss = MCC_GEAR.Missing(id)
                if miss and #miss > 0 then
                    n = n + 1
                    MCC.Util.Reply(ply, "  %s (%s): needs %s", id, MCC.Items.Get(id).name, table.concat(miss, " and "))
                end
            end
            MCC.Util.Reply(ply, n == 0 and "All gear has its models." or ("%d item(s) still use placeholders."):format(n))
        end)
        MCC.Log("MCC Gear %s: %d rigs, %d backpacks", MCC_GEAR.VERSION, table.Count(RIGS), table.Count(BACKPACKS))
    end)
end
