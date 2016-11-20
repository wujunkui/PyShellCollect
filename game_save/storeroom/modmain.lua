PrefabFiles = {
	"cupboard",
}

Assets = 
{
	Asset("ATLAS", "minimap/storeroom.xml" ),
	Asset("ATLAS", "images/inventoryimages/storeroom.xml"),
}

AddMinimapAtlas("minimap/storeroom.xml")

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
_G = GLOBAL

_G.yees = GetModConfigData("Destroyable")=="yees"
_G.mod_slots = GetModConfigData("Slots")

local mod_craft = GetModConfigData("Craft")
local mod_lang = GetModConfigData("Language")
-- проверяем всю ветку для предотвращения ошибок с CAPY_DLC
local mod_capy_dlc = _G.rawget(_G,"CAPY_DLC") and _G.IsDLCEnabled and _G.IsDLCEnabled(_G.CAPY_DLC)

-- description change depending on the language
local function descriptionchange(str)
	local OldModInfo=_G.ModIndex.GetModInfo
	function NewModInfo(self,modname)
		local res=OldModInfo(self,modname) 
			if res and modinfo.name==res.name then
				res.description=str .. res.version
			end
		return res
	end
	_G.ModIndex.GetModInfo=NewModInfo
end

local function updaterecipe(slots)

	if mod_craft=="Easy" then

		cutstone_value = math.floor(slots / 7)
		boards_value = math.floor(slots / 7)
		limestone_value = math.floor(slots / 20)
		marble_value = math.floor(slots / 20)

	elseif mod_craft=="Hard" then

		cutstone_value = math.floor(slots / 2.6)
		boards_value = math.floor(slots / 2.6)
		limestone_value = math.floor(slots / 8)
		marble_value = math.floor(slots / 10)

	else

		cutstone_value = math.floor(slots / 4)
		boards_value = math.floor(slots / 4)
		limestone_value = math.floor(slots / 16)
		marble_value = math.floor(slots / 20)
	end
end
updaterecipe(_G.mod_slots)

print("slots_debug ",_G.mod_slots)
print("recipe_debug ",cutstone_value, boards_value, limestone_value)

if mod_capy_dlc then
	cupboard0 = Recipe("cupboard",{ Ingredient("cutstone", cutstone_value), Ingredient("limestone", limestone_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, _G.RECIPE_GAME_TYPE.COMMON, "cupboard_placer" )
	cupboard1 = Recipe("cupboard",{ Ingredient("cutstone", cutstone_value), Ingredient("marble", marble_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, _G.RECIPE_GAME_TYPE.ROG, "cupboard_placer" )
	cupboard2 = Recipe("cupboard",{ Ingredient("cutstone", cutstone_value), Ingredient("marble", marble_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, _G.RECIPE_GAME_TYPE.VANILLA, "cupboard_placer" )

	cupboard1.atlas = "images/inventoryimages/storeroom.xml"
	cupboard2.atlas = "images/inventoryimages/storeroom.xml"
else
	cupboard0 = Recipe("cupboard",{ Ingredient("cutstone", cutstone_value), Ingredient("marble", marble_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "cupboard_placer" )
end

cupboard0.atlas = "images/inventoryimages/storeroom.xml"

local function updatestoreroom(inst)
	if GetModConfigData("Position")==("Left") then
		inst.components.container.widgetpos = _G.Vector3(-210,230,0)
	elseif GetModConfigData("Position")==("Center") then
		inst.components.container.widgetpos = _G.Vector3(0,190,0)
	end

	if _G.mod_slots==20 then
		inst.components.container.widgetanimbank = "ui_chest_4x5"
		inst.components.container.widgetanimbuild = "ui_chest_4x5"
	elseif _G.mod_slots==40 then
		inst.components.container.widgetanimbank = "ui_chest_5x8"
		inst.components.container.widgetanimbuild = "ui_chest_5x8"
	elseif _G.mod_slots==60 then
		inst.components.container.widgetanimbank = "ui_chest_5x12"
		inst.components.container.widgetanimbuild = "ui_chest_5x12"
	else
		inst.components.container.widgetanimbank = "ui_chest_5x16"
		inst.components.container.widgetanimbuild = "ui_chest_5x16"
	end
end

local RegisterRussianName = GLOBAL.rawget(GLOBAL,"RegisterRussianName")
if RegisterRussianName then
	RegisterRussianName("CUPBOARD","Кладовая","she","Кладовой","Кладовую")
	STRINGS.RECIPE_DESC.CUPBOARD = "Нужно больше места!" 
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.CUPBOARD = "Мне очень нравится это большое хранилище!"
	descriptionchange("Как же долго мы этого ждали.\nВерсия мода: ")
-----------------
--French translation by John2022
elseif mod_lang=="Fr" then
	STRINGS.NAMES.CUPBOARD = "Debarras"
	STRINGS.RECIPE_DESC.CUPBOARD = "Besoin de plus d'espace!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.CUPBOARD = "J'apprecie beaucoup le gain de place!"
	descriptionchange("Depuis le temps qu'on l'attendait!\nMod version: ")
-----------------
else
	STRINGS.NAMES.CUPBOARD = "Storeroom"
	STRINGS.RECIPE_DESC.CUPBOARD = "Need more space!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.CUPBOARD = "I really like this is a great storeroom!"
end

AddPrefabPostInit("cupboard", updatestoreroom)