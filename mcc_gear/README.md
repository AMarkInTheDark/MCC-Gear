# MCC Gear

Escape from Tarkov's chest rigs and backpacks for the MCC inventory. Needs **MCC Base**. Version 0.6.0.

**0.6.0:** 18 more rigs: Tarzan M22, Triton M43-A, Commando (Black, Tan), Thunderbolt (Shadow Grey, Ranger Green, WildWood),
GC-BSS-MK1, Umka M33-SET1, D3CRX (Ranger Green, Black, Coyote Brown, MultiCam), LBT-1961A (MAS Grey, Goons Edition, AOR1,
MultiCam, DNC). Rigs that share a pocket layout use one entry in `LAYOUTS`.

**0.5.0:** four more rigs: WARTECH TV-109 + TV-106, CSA (Black), UMTBS 6Sh112 Scout-Sniper, Azimut SS "Khamelion".

**0.4.0:** five more rigs: DIY IDEA, Bank Robber (MultiCam Black and Alpine), SOE Micro Rig, Type 56 Chicom.

Every rig and backpack works in the inventory now: rigs go in the tactical rig slot, backpacks in the
backpack slot, with Tarkov's size, weight and pocket layout. The models are **placeholders**: an HL2 prop on the ground and in the inventory, and
nothing drawn on the player yet.

| id | Name | Size | Pockets | Weight | Placeholder |
| --- | --- | --- | --- | --- | --- |
| `rig_scav_vest` | Scav Vest | 2x3 | 1x1, 1x2, 1x2, 1x1 (6 slots) | 0.4 kg | garbage bag |
| `rig_security_vest` | Security vest | 2x3 | 1x1, 1x2, 1x2, 1x1 (6 slots) | 0.51 kg | briefcase |
| `rig_m4_rscr` | Zulu Nylon Gear M4 Reduced Signature Chest Rig (Ranger Green) | 2x3 | 3x 1x2 (6 slots) | 0.521 kg | SMG ammo box |
| `rig_idea` | DIY IDEA chest rig | 2x3 | 4x 1x2 (8 slots) | 0.22 kg | garbage bag |
| `rig_bank_robber_black` | Spiritus Systems Bank Robber chest rig (MultiCam Black) | 2x3 | 4x 1x2 (8 slots) | 0.7 kg | SMG ammo box |
| `rig_bank_robber_alpine` | Spiritus Systems Bank Robber chest rig (MultiCam Alpine) | 2x3 | 4x 1x2 (8 slots) | 0.7 kg | SMG ammo box |
| `rig_soe_micro` | SOE Micro Rig (MultiCam) | 2x3 | 2x2, 1x2, 1x2 (8 slots) | 0.8 kg | pistol ammo box |
| `rig_type56` | Type 56 Chicom chest harness | 3x3 | 1x1, 1x1, 3x 1x2, 1x1, 1x1 (10 slots) | 0.65 kg | garbage bag |
| `rig_wartech_tv109` | WARTECH TV-109 + TV-106 chest rig (A-TACS FG) | 3x3 | 2x2, 1x2, 1x2, 1x1, 1x1 (10 slots) | 1.8 kg | SMG ammo crate |
| `rig_csa_black` | CSA chest rig (Black) | 2x3 | 1x3, 1x2, 1x2, 1x3 (10 slots) | 0.75 kg | briefcase |
| `rig_6sh112` | UMTBS 6Sh112 Scout-Sniper chest rig (EMR) | 3x4 | 4x 1x2, 4x 1x1 (12 slots) | 1.7 kg | AR2 ammo crate |
| `rig_khamelion` | Azimut SS "Khamelion" chest harness (Olive) | 3x4 | 4x 1x2, 4x 1x1 (12 slots) | 1.7 kg | AR2 ammo crate |
| `rig_tarzan_m22` | Splav Tarzan M22 chest rig (Smog) | 3x4 | 4x 1x2, 4x 1x1, 1x1 at each end (14 slots) | 1.45 kg | garbage bag |
| `rig_triton_m43a` | Dynaforce Triton M43-A chest harness (Black) | 3x4 | 4x 1x2 over 4x 1x2 (16 slots) | 1.3 kg | briefcase |
| `rig_commando_black` | BlackHawk! Commando chest harness (Black) | 3x4 | 4x 1x2 over 4x 1x2 (16 slots) | 1.35 kg | SMG ammo box |
| `rig_commando_tan` | BlackHawk! Commando chest harness (Desert Tan) | 3x4 | 4x 1x2 over 4x 1x2 (16 slots) | 1.35 kg | SMG ammo box |
| `rig_thunderbolt_grey` | Direct Action Thunderbolt compact chest rig (Shadow Grey) | 3x3 | 4x 1x2 over 1x2, 1x2, 1x1/1x1, 1x2 (16 slots) | 0.62 kg | pistol ammo box |
| `rig_thunderbolt_green` | Direct Action Thunderbolt compact chest rig (Ranger Green) | 3x3 | as the Shadow Grey (16 slots) | 0.62 kg | pistol ammo box |
| `rig_thunderbolt_wildwood` | Direct Action Thunderbolt compact chest rig (PenCott WildWood) | 3x3 | as the Shadow Grey (16 slots) | 0.62 kg | pistol ammo box |
| `rig_bss_mk1` | Gear Craft GC-BSS-MK1 chest rig (A-TACS FG) | 3x3 | 4x 1x2 over 1x2, 1x1/1x1, 1x1/1x1, 1x2 (16 slots) | 1.0 kg | SMG ammo crate |
| `rig_umka_m33` | Umka M33-SET1 hunter vest (Olive Drab) | 3x4 | 4x 1x2 over 1x1/1x1, 1x1/1x1, 2x2 (16 slots) | 1.2 kg | garbage bag |
| `rig_d3crx_green` | Haley Strategic D3CRX Chest Harness (Ranger Green) | 3x3 | as the BSS-MK1 (16 slots) | 0.9 kg | AR2 ammo crate |
| `rig_d3crx_black` | Haley Strategic D3CRX Chest Harness (Black) | 3x3 | as the BSS-MK1 (16 slots) | 0.9 kg | AR2 ammo crate |
| `rig_d3crx_coyote` | Haley Strategic D3CRX Chest Harness (Coyote Brown) | 3x3 | as the BSS-MK1, plus a 2x1 underneath (18 slots) | 0.9 kg | AR2 ammo crate |
| `rig_d3crx_multicam` | Haley Strategic D3CRX Chest Harness (MultiCam) | 3x3 | as the Coyote Brown (18 slots) | 0.9 kg | AR2 ammo crate |
| `rig_lbcr_grey` | LBT-1961A Load Bearing Chest Rig (MAS Grey) | 3x3 | 2x 2x2 over 4x 1x2, two 1x1 below (18 slots) | 1.36 kg | SMG ammo crate |
| `rig_lbcr_goons` | LBT-1961A Load Bearing Chest Rig (Goons Edition) | 3x3 | as the MAS Grey (18 slots) | 1.36 kg | SMG ammo crate |
| `rig_lbcr_aor1` | LBT-1961A Load Bearing Chest Rig (AOR1) | 3x3 | as the MAS Grey (18 slots) | 1.36 kg | SMG ammo crate |
| `rig_lbcr_multicam` | LBT-1961A Load Bearing Chest Rig (MultiCam) | 3x3 | as the MAS Grey (18 slots) | 1.36 kg | SMG ammo crate |
| `rig_lbcr_dnc` | LBT-1961A Load Bearing Chest Rig (DNC) | 3x3 | as the MAS Grey (18 slots) | 1.36 kg | SMG ammo crate |

| id | Backpack | Size | Inside | Weight | Placeholder |
| --- | --- | --- | --- | --- | --- |
| `bp_sling_khaki` | Tactical sling bag (Khaki) | 3x3 | 2x3 (6 slots) | 0.48 kg | passenger suitcase |
| `bp_vkbo` | VKBO army bag | 3x4 | 2x4 (8 slots) | 0.96 kg | garbage bag |
| `bp_tbag` | Transformer Bag | 3x3 | 3x3 (9 slots) | 0.84 kg | suitcase |

Tarkov's move speed, turn speed and ergonomics penalties (sling 0/0/-2%, VKBO -1/0/-1%, T-Bag 0/0/-2%) are
stored in each item's `data.stats` for when MCC has movement effects; they don't do anything yet.

## Adding the models
Each rig and backpack needs two:
- `model`: how it looks on the ground and in the inventory.
- `worn`: a model rigged to the player skeleton, which MCC bonemerges onto the character (other players
  see it, and it stays on bodies).

Fill in `model = ...` and `worn = ...` for the rig in `lua/autorun/mcc_gear_init.lua` and restart, or set
them in the console without editing Lua (saved to data/mcc/items.json):
```
mcc_item_set rig_scav_vest model models/your/scav_vest.mdl
mcc_item_set rig_scav_vest data.worn models/your/scav_vest_worn.mdl
```
A model that isn't rigged can be stuck to a bone instead: see "Worn gear" in MCC Base's README.
`mcc_gear_missing` (moderator) lists the gear still waiting for models.

## Adding more rigs and backpacks
For a rig whose pockets match one in `LAYOUTS` (a colour variant, say), add one line to `MORE_RIGS`. Otherwise copy an entry
in `RIGS` (or `BACKPACKS`): the id, Tarkov's name, size (`w`, `h`), weight, and `cells`, one per pocket
as `{x, y, w, h}` in squares, with `.1` gaps between pockets (so the second pocket starts at `x = 1.1`). Give it a
`short` name for the spawn menu; it gets its spawn menu entry automatically.

## Install
Copy `mcc_gear` into `garrysmod/addons/`, next to `mcc_base`. Rigs and backpacks are in the spawn menu
under **Entities > MCC Equipment - Rigs** and **MCC Equipment - Backpacks** (they drop in the world as
items: E to pick up), or `mcc_give rig_scav_vest` / `mcc_give bp_vkbo`.

## Tests
`python3 tests/test_gear.py` (needs Python 3, `pip install lupa`, and MCC Base next to this folder).
