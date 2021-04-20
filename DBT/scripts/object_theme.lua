rand_obj.themed.register_new
(
	"THEME_TREASURE",
	function(obj_level, theme_flags)
		local obj = new_object()

		if not make_gold(obj) then
			delete_object(obj)
			return
		end
		return obj
	end
)

--[[
rand_obj.themed.register_new("THEME_ALLOC_HANDLER",
{
	[TV_ENTANGLEARM] = 1
	[TV_POLEARM] = 1
	[TV_SWORDARM] = 1
	[TV_SMALLARM] = 1
	[TV_BOOTS] = 1
	[TV_GLOVES] = 1
	[TV_BRACERS] = 1
	[TV_HEADPIECE] = 1
	[TV_SHIELD] = 1
	[TV_CLOAK] = 1
	[TV_BODY_ARMOUR] = 1
	[TV_TOOL] = 1
	[TV_LITE] = 1
	[TV_CIRCUITRY] = 1
	[TV_ELECTRONICS] = 1
	[TV_FOOD] = 1
	[TV_DRINK] = 1
	[TV_POTION] = 1
	[TV_GOLD] = 1
})
]]

-- Single TVAL Themes:
rand_obj.themed.register_new("THEME_ELECTRONICS", { [TV_ELECTRONICS] = 1 })
rand_obj.themed.register_new("THEME_BATTERY", { [TV_BATTERY] = 1 })
rand_obj.themed.register_new("THEME_JUNK", { [TV_JUNK] = 1 })
rand_obj.themed.register_new("THEME_FOOD", { [TV_FOOD] = 1 })
rand_obj.themed.register_new("THEME_BONES", { [TV_DBT_BONES] = 1 })

rand_obj.themed.register_new("THEME_TPEOPLE",
{
	[TV_JUNK] = 1
	[TV_FOOD] = 1
	[TV_BATTERY] = 1
	[TV_GOLD] = 1
})

rand_obj.themed.register_new("THEME_BALLISTICS",
{
	[TV_CLIP] = 1
	[TV_GUN] = 1
})

rand_obj.themed.register_new("THEME_BLUEPRINTS",
{
	[TV_BLUEPRINTS] = 1
})

rand_obj.themed.register_new("THEME_BRIEFS",
{
	[TV_HIGH_TECH_COMPONENTS] = 1
	[TV_BLUEPRINTS] = 1
})

-- Why? Because this way I can actually generate sushi.
-- If I just do TV_SUSHI = 1, then level allocations
-- get in the way
rand_obj.themed.register_new
(
	"THEME_SUSHI",
	function(obj_level, theme_flags)
		local which = rng(1,5)
		local obj
		if which == 1 then
			obj = create_object(TV_SUSHI, SV_SUSHI_UNAGI)
		elseif which == 2 then
			obj = create_object(TV_SUSHI, SV_SUSHI_ANAGO)
		elseif which == 3 then
			obj = create_object(TV_SUSHI, SV_SUSHI_SABA)
		elseif which == 4 then
			obj = create_object(TV_SUSHI, SV_SUSHI_TAKKO)
		else
			obj = create_object(TV_SUSHI, SV_SUSHI_FUGU)
		end
		return obj
	end
)

rand_obj.themed.register_new
(
	"THEME_TOXIC",
	function(obj_level, theme_flags)
		local obj = create_object(TV_POTION, SV_NUCLEAR_WASTE)
		return obj
	end
)

rand_obj.themed.register_new
(
	"THEME_GOLD",
	function(obj_level, theme_flags)
		local obj = new_object()

		if not make_gold(obj) then
			delete_object(obj)
			return
		end
		return obj
	end
)

rand_obj.themed.register_new
(
	"THEME_ACCESSORY",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.accessory_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_PLAIN",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.plain_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_MARTIAL",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.ma_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_CHINESE",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.chinese_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_JAPANESE",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.japanese_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_NINJA",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.ninja_item_tester})
		if wizard then message(" k:" .. k_idx) end
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_RRA",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.rra_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_FRENCH",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.french_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_POLICE",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.police_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_NAMEK",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.namek_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)
rand_obj.themed.register_new
(
	"THEME_TECHNO",
	function(obj_level, theme_flags, extra_filter)
		local k_idx = rand_obj.rand_k_idx(object_level, 1, {dball.techno_item_tester})
		local obj = new_object()
		object_prep(obj, k_idx)
		return obj
	end
)

-- Stores customization
flag_set(store.make_obj.full_random_theme, FLAG_THEME_PLAIN, 50)
flag_set(store.make_obj.full_random_theme, FLAG_THEME_ELECTRONICS, 50)
