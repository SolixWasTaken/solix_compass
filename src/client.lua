local isPlayerInVehicle = false

function ToggleCompass(toggle)
    SendNuiMessage(json.encode({
        toggle = toggle
    }))
end
exports('ToggleCompass', ToggleCompass)

lib.onCache('vehicle', function(value)
    if (value) then 
        isPlayerInVehicle = true
        ToggleCompass('show')
    else
        isPlayerInVehicle = false
        ToggleCompass('hide')
    end
end)

local function GetCompassDirection()
    local ped = cache.ped
    local heading = GetEntityHeading(ped)

    local directions = { 
    [0] = 'N', 
    [45] = 'NW', 
    [90] = 'W', 
    [135] = 'SW', 
    [180] = 'S', 
    [225] = 'SE', 
    [270] = 'E', 
    [315] = 'NE', 
    [360] = 'N', 
 }

    for k, v in pairs(directions) do 
        if (math.abs(heading - k) < 22.5) then 
            return v;
        end
    end
end

local function GetNameOfArea()
    local ped = cache.ped 
    local playerCoords = GetEntityCoords(ped)

    local zoneName = GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z)

    local zoneLabel = GetLabelText(zoneName)

    return zoneLabel
end

local function GetStreetNames()
    local ped = cache.ped
    local playerCoords = GetEntityCoords(ped)

    local streetNameHash, crossingHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)

    local streetName = GetStreetNameFromHashKey(streetNameHash)
    local crossingName = GetStreetNameFromHashKey(crossingHash)
    
    if (streetName and crossingName ~= '') then
        return ('%s x %s'):format(streetName, crossingName)
    else
        return streetName
    end
end

CreateThread(function()
    while true do
        if (isPlayerInVehicle) then
            local ped = cache.ped
            local compassDirection = GetCompassDirection()
            local streetName = GetStreetNames()
            local areaName = GetNameOfArea()

             SendNuiMessage(json.encode({
                compass = compassDirection,
                streetName = streetName,
                areaName = areaName
            }))

            Wait(Config.Interval)
        else
            Wait(1000)
        end
    end

end)
