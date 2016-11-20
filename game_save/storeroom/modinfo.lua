name = " Storeroom"
author = "MrM"
version = "2.1a"
description = "How long have we been waiting it.\nMod version: "..version

forumthread = ""

api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
priority = -1.01 -- for compatible with RLP

icon_atlas = "storeroom.xml"
icon = "storeroom.tex"
----------------

local russian = language == "ru"

configuration_options =
{
	{
		name = "Craft",
		label = russian and "Создание" or "Craft",
		options =
	{
		{description = russian and "Лёгкое" or "Easy", data = "Easy"},
		{description = russian and "Нормальное" or "Normal", data = "Normal"},
		{description = russian and "Сложное" or "Hard", data = "Hard"},
	},
		default = "Normal",
	},

	{
		name = "Slots",
		label = russian and "Слоты" or "Slots",
		options =
	{
		{description = "20", data = 20},
		{description = "40", data = 40},
		{description = "60", data = 60},
		{description = "80", data = 80},
	},
		default = 80,
	},

	{
		name = "Position",
		label = russian and "Позиция" or "Position",
		options =
	{
		{description = russian and "Слева" or "Left", data = "Left"},
		{description = russian and "По центру" or "Center", data = "Center"},
	},
		default = "Center",
	},

	{
		name = "Destroyable",
		label = russian and "Разрушаемость" or "Destroyable",
		options =
	{
		{description = russian and "Включена" or "Enabled", data = "yees"},
		{description = russian and "Выключена" or "Disabled ", data = "noo"},
	},
		default = "yees",
	},

	{
		name = "Language",
		label = russian and "Язык" or "Language",
		options =
	{
		{description = "English", data = "En"},
		{description = "Francais", data = "Fr"},
	},
		default = "En",
	},
}