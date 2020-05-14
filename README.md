# OSINT_addon

Addon for World of Warcraft which collect all characters names across your realm via combat log and current target.

All parsed data is stored in `data` variable at this **%PATH%**:

```
*\World of Warcraft\_retail_\WTF\Account\%account_name%\%realm%\%name%\SavedVariables
```

Format: 

```
	["data"] = {
		{
			["guid"] = "Player-1602-0B401026", // character's guid, {name}-{connected_realm}-{guid}
			["class"] = "Разбойница",
			["race"] = "Человек",
			["name"] = "Инициатива", 
			["sex"] = 3, //1 - ?, 2 - male, 3 - female
			["classSlug"] = "ROGUE",
			["raceSlug"] = "Human",
			["timestamp"] = 1587579319.252,
			["realm"] = "Гордунни",
		}, -- [1]
  }
```
