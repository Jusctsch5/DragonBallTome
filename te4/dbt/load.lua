-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009 - 2019 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

-- This file loads the game module, and loads data
local KeyBind = require "engine.KeyBind"
local DamageType = require "engine.DamageType"
local ActorStats = require "engine.interface.ActorStats"
local ActorResource = require "engine.interface.ActorResource"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorAI = require "engine.interface.ActorAI"
local ActorLevel = require "engine.interface.ActorLevel"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Birther = require "engine.Birther"

-- Useful keybinds
KeyBind:load("move,hotkeys,inventory,actions,interface,debug")

-- Damage types
DamageType:loadDefinition("/data/damage_types.lua")

-- Talents
ActorTalents:loadDefinition("/data/talents.lua")

-- Timed Effects
ActorTemporaryEffects:loadDefinition("/data/timed_effects.lua")

-- Actor resources
ActorResource:defineResource("Power", "power", nil, "power_regen", "Power represent your ability to use special talents.")
ActorResource:defineResource("Chi", "chi", nil, "chi_regen", "Spiritual energy. It stays empty until a master teaches you.")

-- Actor stats. Birth starts each at 10. The arrangement screen can move them between 6 and 14.
ActorStats:defineStat("Strength", "str", 10, 1, 100, "Melee damage is Strength minus 10, before the weapon roll.")
ActorStats:defineStat("Intelligence", "int", 10, 1, 100, "Intelligence is for machines and noticing things. It does not change a punch.")
ActorStats:defineStat("Willpower", "wil", 10, 1, 100, "Willpower feeds chi, once you have learned to use it.")
ActorStats:defineStat("Dexterity", "dex", 10, 1, 100, "Barehand and weapon to-hit is Dexterity minus 10.")
ActorStats:defineStat("Constitution", "con", 10, 1, 100, "Life is Constitution times your level.")
ActorStats:defineStat("Charisma", "chr", 10, 1, 100, "Charisma sets your starting zeni and the price shops charge.")
ActorStats:defineStat("Speed", "spd", 10, 1, 100, "Speed is how quickly you act. 10 is normal.")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

return {require "mod.class.Game" }
