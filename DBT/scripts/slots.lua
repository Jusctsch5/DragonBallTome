-- Equipment slots

declare_global_constants
{
	"INVEN_WIELD",
	"INVEN_RING",
	"INVEN_WRIST",
	"INVEN_BODY",
	"INVEN_OUTER",
	"INVEN_HEAD",
	"INVEN_HANDS",
	"INVEN_ARMS",
	"INVEN_FEET",
	"INVEN_TOOL",
	"INVEN_BACKPACK",
	"INVEN_VEHICLE",
}

INVEN_WIELD	= add_new_inventory_slot("hand",	"In hand", 	"wielding in your hand",	"You are wielding",	"You were wielding")
INVEN_RING	= add_new_inventory_slot("finger",	"On finger", 	"wearing on your finger",	"You are wearing",	"You were wearing")
INVEN_WRIST	= add_new_inventory_slot("wrist",	"On wrist",	"wearing around your wrist",	"You are wearing",	"You were wearing")
INVEN_BODY	= add_new_inventory_slot("body",	"On body", 	"wearing on your body",		"You are wearing",	"You were wearing")
INVEN_OUTER	= add_new_inventory_slot("cloak",	"About body",	"wearing on your back",		"You are wearing",	"You were wearing")
INVEN_HEAD	= add_new_inventory_slot("head",	"On head", 	"wearing on your head",		"You are wearing",	"You were wearing")
INVEN_HANDS	= add_new_inventory_slot("hands",	"On hands", 	"wearing on your hands",	"You are wearing",	"You were wearing")
INVEN_ARMS	= add_new_inventory_slot("forearms","On forearms", 	"wearing on your arms",	"You are wearing",	"You were wearing")
INVEN_FEET	= add_new_inventory_slot("feet",	"On feet", 	"wearing on your feet",		"You are wearing",	"You were wearing")
INVEN_TOOL	= add_new_inventory_slot("tool",	"Using", 	"using",			"You are using",	"You were using")
INVEN_BACKPACK	= add_new_inventory_slot("backpack",	"Backpack", 	"using as backpack",		"Your backpack is",	"Your backpack was")
INVEN_VEHICLE = add_new_inventory_slot("vehicle", "Vehicle", "riding", "You are riding", "You were riding")

-- INVEN_WIELD is the first slot to be considered equipment
INVEN_PACK = INVEN_WIELD
