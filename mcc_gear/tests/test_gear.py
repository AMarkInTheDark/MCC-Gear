"""MCC Gear tests: the Tarkov rigs register with MCC Base, their pocket layouts are sane, and
models can be filled in later without code. Needs MCC Base next to this folder (../mcc_base)."""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
BASE_TESTS = os.environ.get("MCC_BASE_TESTS", os.path.join(HERE, "..", "..", "mcc_base", "tests"))
sys.path.insert(0, BASE_TESTS)
from gmod_mock import Realm
GEAR_LUA = os.path.join(HERE, "..", "lua")

failures = []
def check(cond, msg):
    print(("PASS " if cond else "FAIL ") + msg)
    if not cond:
        failures.append(msg)

sv = Realm("server", extra_roots=[GEAR_LUA])
sv.run('_SENTS = {} scripted_ents = {Register = function(t, c) _SENTS[c] = t end, Get = function(c) return _SENTS[c] end}')
sv.load_mcc()
sv.run('include("autorun/mcc_gear_init.lua")')
sv.boot()
L, run = sv.eval, sv.run

ids = sorted(L('(function() local t = {} for id in pairs(MCC_GEAR.RIGS) do t[#t + 1] = id end table.sort(t) return table.concat(t, ",") end)()').split(","))
bps = sorted(L('(function() local t = {} for id in pairs(MCC_GEAR.BACKPACKS) do t[#t + 1] = id end table.sort(t) return table.concat(t, ",") end)()').split(","))
RIG_IDS = ['rig_6sh112', 'rig_bank_robber_alpine', 'rig_bank_robber_black', 'rig_bss_mk1', 'rig_commando_black', 'rig_commando_tan', 'rig_csa_black', 'rig_d3crx_black', 'rig_d3crx_coyote', 'rig_d3crx_green', 'rig_d3crx_multicam', 'rig_idea', 'rig_khamelion', 'rig_lbcr_aor1', 'rig_lbcr_dnc', 'rig_lbcr_goons', 'rig_lbcr_grey', 'rig_lbcr_multicam', 'rig_m4_rscr', 'rig_scav_vest', 'rig_security_vest', 'rig_soe_micro', 'rig_tarzan_m22', 'rig_thunderbolt_green', 'rig_thunderbolt_grey', 'rig_thunderbolt_wildwood', 'rig_triton_m43a', 'rig_type56', 'rig_umka_m33', 'rig_wartech_tv109']
check(ids == sorted(RIG_IDS), "the %d Tarkov rigs: %s" % (len(RIG_IDS), ", ".join(ids)))
for id in ids:
    ok = L('MCC.Items.Get("%s") ~= nil' % id) and L('MCC.Items.Get("%s").kind' % id) == "gear" and L('MCC.Items.Get("%s").data.slot' % id) == "rig"
    check(ok, "%s is a rig item (%s)" % (id, L('MCC.Items.Get("%s").name' % id)))
    cells = [(L('MCC.Items.Get("%s").data.cells[%d].x' % (id, i)), L('MCC.Items.Get("%s").data.cells[%d].y' % (id, i)),
              L('MCC.Items.Get("%s").data.cells[%d].w' % (id, i)), L('MCC.Items.Get("%s").data.cells[%d].h' % (id, i)))
             for i in range(1, L('#MCC.Items.Get("%s").data.cells' % id) + 1)]
    overlap = any(a[0] < b[0] + b[2] and b[0] < a[0] + a[2] and a[1] < b[1] + b[3] and b[1] < a[1] + a[3]
                  for i, a in enumerate(cells) for b in cells[i + 1:])
    check(not overlap and all(c[2] >= 1 and c[3] >= 1 for c in cells), "  its %d pockets don't overlap" % len(cells))
def layout(id):
    n = L('#MCC.Items.Get("%s").data.cells' % id)
    return [(L('MCC.Items.Get("%s").data.cells[%d].w' % (id, i)), L('MCC.Items.Get("%s").data.cells[%d].h' % (id, i))) for i in range(1, n + 1)]
def slots(id): return sum(w * h for w, h in layout(id))
for id, want, kg, size in (("rig_idea", [(1, 2)] * 4, 0.22, (2, 3)), ("rig_bank_robber_black", [(1, 2)] * 4, 0.7, (2, 3)),
                           ("rig_bank_robber_alpine", [(1, 2)] * 4, 0.7, (2, 3)), ("rig_soe_micro", [(2, 2), (1, 2), (1, 2)], 0.8, (2, 3)),
                           ("rig_type56", [(1, 1), (1, 1), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 0.65, (3, 3)),
                           ("rig_wartech_tv109", [(2, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 1.8, (3, 3)),
                           ("rig_csa_black", [(1, 3), (1, 2), (1, 2), (1, 3)], 0.75, (2, 3)),
                           ("rig_6sh112", [(1, 2)] * 4 + [(1, 1)] * 4, 1.7, (3, 4)),
                           ("rig_khamelion", [(1, 2)] * 4 + [(1, 1)] * 4, 1.7, (3, 4)),
                           ('rig_tarzan_m22', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1)], 1.45, (3, 4)),
                           ('rig_triton_m43a', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2)], 1.3, (3, 4)),
                           ('rig_commando_black', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2)], 1.35, (3, 4)),
                           ('rig_commando_tan', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2)], 1.35, (3, 4)),
                           ('rig_thunderbolt_grey', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 2)], 0.62, (3, 3)),
                           ('rig_thunderbolt_green', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 2)], 0.62, (3, 3)),
                           ('rig_thunderbolt_wildwood', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 2)], 0.62, (3, 3)),
                           ('rig_bss_mk1', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (1, 2)], 1.0, (3, 3)),
                           ('rig_umka_m33', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (2, 2)], 1.2, (3, 4)),
                           ('rig_d3crx_green', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (1, 2)], 0.9, (3, 3)),
                           ('rig_d3crx_black', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (1, 2)], 0.9, (3, 3)),
                           ('rig_d3crx_coyote', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (1, 2), (2, 1)], 0.9, (3, 3)),
                           ('rig_d3crx_multicam', [(1, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1), (1, 1), (1, 1), (1, 2), (2, 1)], 0.9, (3, 3)),
                           ('rig_lbcr_grey', [(2, 2), (2, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 1.36, (3, 3)),
                           ('rig_lbcr_goons', [(2, 2), (2, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 1.36, (3, 3)),
                           ('rig_lbcr_aor1', [(2, 2), (2, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 1.36, (3, 3)),
                           ('rig_lbcr_multicam', [(2, 2), (2, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 1.36, (3, 3)),
                           ('rig_lbcr_dnc', [(2, 2), (2, 2), (1, 2), (1, 2), (1, 2), (1, 2), (1, 1), (1, 1)], 1.36, (3, 3))):
    check(layout(id) == want and L('MCC.Items.Get("%s").weight' % id) == kg and (L('MCC.Items.Get("%s").w' % id), L('MCC.Items.Get("%s").h' % id)) == size,
          "%s: %d slots, %s kg, %dx%d (as in Tarkov)" % (id, slots(id), kg, size[0], size[1]))
check(layout("rig_scav_vest") == [(1, 1), (1, 2), (1, 2), (1, 1)] and L('MCC.Items.Get("rig_scav_vest").weight') == 0.4,
      "Scav Vest: 1x1, 1x2, 1x2, 1x1 (6 slots), 0.4 kg")
check(layout("rig_security_vest") == [(1, 1), (1, 2), (1, 2), (1, 1)] and L('MCC.Items.Get("rig_security_vest").weight') == 0.51,
      "Security vest: the same pockets, 0.51 kg")
check(layout("rig_m4_rscr") == [(1, 2), (1, 2), (1, 2)] and L('MCC.Items.Get("rig_m4_rscr").weight') == 0.521,
      "M4 RSCR: three 1x2 pouches (6 slots), 0.521 kg")
check(all(L('MCC.Items.Get("%s").w' % i) == 2 and L('MCC.Items.Get("%s").h' % i) == 3 for i in ids
          if i in ("rig_scav_vest", "rig_security_vest", "rig_m4_rscr")),
      "the small ones are 2x3 in the inventory (bigger ones checked above)")
run('_RIG = MCC.Inv.NewItem("rig_m4_rscr", 1)')
check(L('#_RIG.cont') == 3, "a rig item comes with a storage grid per pocket")
check(L('MCC.Items.Get("rig_scav_vest").model') == "models/props_junk/garbage_bag001a.mdl" and L('MCC.Items.Get("rig_scav_vest").data.worn') is None,
      "they show an HL2 prop as a placeholder and aren't drawn on players yet")

check(bps == ["bp_sling_khaki", "bp_tbag", "bp_vkbo"], "the three Tarkov backpacks: %s" % ", ".join(bps))
for id in bps:
    check(L('MCC.Items.Get("%s").kind' % id) == "gear" and L('MCC.Items.Get("%s").data.slot' % id) == "backpack"
          and L('MCC.Items.Get("%s").category' % id) == "backpacks", "%s is a backpack item (%s)" % (id, L('MCC.Items.Get("%s").name' % id)))
check(layout("bp_sling_khaki") == [(2, 3)] and L('MCC.Items.Get("bp_sling_khaki").w') == 3 and L('MCC.Items.Get("bp_sling_khaki").h') == 3
      and L('MCC.Items.Get("bp_sling_khaki").weight') == 0.48, "Tactical sling bag: 3x3, 2x3 inside (6 slots), 0.48 kg")
check(layout("bp_vkbo") == [(2, 4)] and L('MCC.Items.Get("bp_vkbo").w') == 3 and L('MCC.Items.Get("bp_vkbo").h') == 4
      and L('MCC.Items.Get("bp_vkbo").weight') == 0.96, "VKBO army bag: 3x4, 2x4 inside (8 slots), 0.96 kg")
check(layout("bp_tbag") == [(3, 3)] and L('MCC.Items.Get("bp_tbag").weight') == 0.84, "Transformer Bag: 3x3, 3x3 inside (9 slots), 0.84 kg")
check(L('MCC.Items.Get("bp_vkbo").data.stats.move') == -1 and L('MCC.Items.Get("bp_tbag").data.stats.ergonomics') == -2, "(Tarkov's penalties kept for later)")
run('_BP = MCC.Inv.NewItem("bp_vkbo", 1)')
check(L('#_BP.cont') == 1 and L('MCC.Inv.SlotAccepts("backpack", MCC.Items.Get("bp_vkbo"))') is True, "a backpack fits the backpack slot and has its grid")
check(L('_SENTS["mcc_gear_bp_vkbo"].Category') == "MCC Equipment - Backpacks" and L('_SENTS["mcc_gear_bp_vkbo"].PrintName') == "VKBO",
      "backpacks are in the spawn menu under Entities > MCC Equipment - Backpacks")
check(L('_SENTS["mcc_gear_rig_scav_vest"].Category') == "MCC Equipment - Rigs" and L('_SENTS["mcc_gear_rig_scav_vest"].Spawnable') is True,
      "each rig is in the spawn menu under Entities > MCC Equipment - Rigs")
check(L('_SENTS["mcc_gear_rig_m4_rscr"].PrintName') == "M4 RSCR" and L('_SENTS["mcc_gear_rig_security_vest"].MCCItemID') == "rig_security_vest",
      "(short names in the menu)")
run('_SPAWNED = nil MCC.Inv.SpawnFromMenu = function(id, ply, tr) _SPAWNED = id return true end')
run('_SENTS["mcc_gear_rig_m4_rscr"]:SpawnFunction(nil, {Hit = true})')
check(L('_SPAWNED') == "rig_m4_rscr", "spawning one drops that rig in the world as an item")

out = []
run('_GOUT = {} MCC.Util.Reply = function(ply, fmt, ...) _GOUT[#_GOUT + 1] = select("#", ...) > 0 and string.format(fmt, ...) or fmt end')
run('_CMDS["mcc_gear_missing"](nil, "mcc_gear_missing", {}, "")')
lines = [L('_GOUT[%d]' % i) for i in range(1, L('#_GOUT') + 1)]
check(sum(1 for l in lines if "needs model and worn" in l) == len(RIG_IDS) + 3, "mcc_gear_missing lists all %d waiting for models" % (len(RIG_IDS) + 3))
run('_CMDS["mcc_item_set"](nil, "mcc_item_set", {"rig_scav_vest", "data.worn", "models/test/scav_worn.mdl"}, "")')
run('_CMDS["mcc_item_set"](nil, "mcc_item_set", {"rig_scav_vest", "model", "models/test/scav.mdl"}, "")')
check(L('MCC.Items.Get("rig_scav_vest").data.worn') == "models/test/scav_worn.mdl" and L('MCC.Items.Get("rig_scav_vest").model') == "models/test/scav.mdl",
      "mcc_item_set fills in a rig's models without touching Lua")
check(L('#MCC_GEAR.Missing("rig_scav_vest")') == 0 and L('#MCC_GEAR.Missing("rig_m4_rscr")') == 2, "and it drops off the missing list")
check(L('#MCC.Items.Get("rig_scav_vest").data.cells') == 4, "(its pockets are kept)")

# MCC Base's old generic Scav Vest (rig_scav, removed in Base 0.17.0) comes back as this one
check(L('MCC.Items.Get("rig_scav")') is None, "MCC Base no longer has its own Scav Vest (rig_scav)")
run("""
local function A(x, y) return {u = MCC.Inv.NewUID(), id = "ammo_pistol", n = 5, x = x, y = y} end
_OLD = {u = 1, id = "rig_scav", cont = {{A(0, 0), A(0, 1)}, {A(0, 1)}, {}, {A(0, 0)}}}
_P = {MCCInv = nil, SteamID64 = function() return "777" end}
MCC.Data.Set("inv", "777", {slots = {rig = _OLD}, session = MCC.Inv.Session})
MCC.Inv.Load(_P)""")
check(L('_P.MCCInv.slots.rig.id') == "rig_scav_vest", "a saved rig_scav loads as MCC Gear's Scav Vest")
check(L('#_P.MCCInv.slots.rig.cont[1]') == 1 and L('#_P.MCCInv.slots.rig.cont[2]') == 1 and L('#_P.MCCInv.slots.rig.cont[4]') == 1,
      "keeping what fits its pockets (the 1x1 pockets lose what sat in their second row)")
run('_LIST = {{u = 2, id = "rig_scav", cont = {{}, {}, {}, {}}}} MCC.Inv.Prune(_LIST)')
check(L('#_LIST') == 1 and L('_LIST[1].id') == "rig_scav_vest", "in extraction crates too")

print()
print("%d failure(s)" % len(failures))
sys.exit(1 if failures else 0)
