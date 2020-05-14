local _, addon = ...

addon.hostiles = {}

--[[ Common functions ]] --

function addon:SetCounter()
    local count = table.getn(OSINT.data)

    self.frame.counter:SetText(count)

    if (count == 0) then self.frame.background:SetTexture('Interface/Icons/Spell_Holy_ElunesGrace') end
    if (count == 0 and OSINT.autohide) then self.frame:Hide() end

    if (count >= 1) then self.frame.background:SetTexture('Interface/Icons/Ability_Creature_Cursed_02') end
    if (count >= 1 or not OSINT.autohide) then self.frame:Show() end
end

function addon:SetHostile(timestamp, guid)
    local inTable = false

    for _, value in pairs(OSINT.data) do
        if (value.guid == guid) then
            value.timestamp = timestamp
            inTable = true
        end
    end

    if (inTable == false) then
        if (guid ~= "") then
            local class, classSlug, race, raceSlug, sex, name, realm = GetPlayerInfoByGUID(guid)

            if (realm == "")  then
                realm = GetRealmName()
            end

            local character = {
                ['class'] = class,
                ['classSlug'] = classSlug,
                ['guid'] = guid,
                ['name'] = name,
                ['race'] = race,
                ['raceSlug'] = raceSlug,
                ['realm'] = realm,
                ['sex'] = sex,
                ['timestamp'] = timestamp,
            }

            table.insert(OSINT.data, character)
            table.insert(OSINT.csv, string.format("%s,%s", character.name, character.realm))
        end
    end

    --table.sort(self.hostiles, function(a, b) return a.name < b.name end)
    --table.sort(self.hostiles, function(a, b) return a.timestamp > b.timestamp end)

    self:SetTicker()
end


--[[ Ticker functions ]] --

function addon:RemTicker()
    local count = table.getn(OSINT.data)

    if (count == 0) then self.ticker:Cancel() end
    if (count == 0) then self.ticker = nil end
end

function addon:SetTicker()
    if (self.ticker ~= nil) then return end

    self.ticker = C_Timer.NewTicker(1, function()

        for key = table.getn(OSINT.data), 1, -1 do
            local timestamp = OSINT.data[key].timestamp
        end

        self.frame:SetTooltip()

        self:SetCounter()
        self:RemTicker()
    end)
end
