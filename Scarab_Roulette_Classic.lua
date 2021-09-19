--[[
    This is the LUA code for the Classic WoW Scarab Roulette addon.
    Author: Felin - Blaumeux
    Last Updated: 10/26/2020
    Version: 1.0
]]



-- An array filled with the qiraji resonating crystals in-game item links of the qiraji crystals in the players bag.
local player_crystals = {}
-- The number of qiraji crustals the 
local total_crystals = 0
-- 21176 is the Classic WoW item code for the (legendary) black qiraji resonating crystal.
local black = tostring(21176)
-- 21321 is the Classic WoW item code for the red qiraji resonating crystal.
local red = tostring(21321)
-- 21323 is the Classic WoW item code for the green qiraji resonating crystal.
local green = tostring(21323)
-- 21324 is the Classic WoW item code for the yellow qiraji resonating crystal.
local yellow = tostring(21324)
-- 21218 is the Classic WoW item code for the blue qiraji resonating crystal
local blue = tostring(21218)

-- These variables hold the in-game item link's of the mounts.
local blbag, blslot
local rbag, rslot
local gbag, gslot
local ybag, yslot
local bbag, bslot


-- this function gets where in your bags the mounts are located.
local function getBag(mount)
    -- for all bags...
    for b = 0, 4, 1 do
        -- for all slots in the bags
        for s = 1, GetContainerNumSlots(b), 1 do
            if(tostring(select(-1, GetContainerItemInfo(b,s))) == mount) then
                -- increment the total crystals by one.
                print("Add 1 crystal")
                total_crystals = total_crystals + 1
                table.insert(player_crystals, mount)
                return b, s
            end
        end
    end
end


--this function gets all mount locations in the players bags
local function getBagSpots()
    print("gothere5")
    --blbag, blslot = getBag(black)
    print("gothere6")
    --rbag, rslot = getBag(red)
    print("gothere7")
    gbag, gslot = getBag(green)
    print("gothere8")
    ybag, yslot = getBag(yellow)
    print("gothere9")
    bbag, bslot = getBag(blue)
    print("gothere00")
end


-- This function runs the addon.
local function getMount()
    print("got here2")
    -- Check to see if the player is in AQ40 (InstanceID: 3428).
    if(GetRealZoneText() == "Ahn'Qiraj") then
        getBagSpots()
        print("gothere3")
        -- get the random mount out of player_crystals and use it.
        local usemount = player_crystals[math.random(total_crystals)]
        print("gothere4)")
        if usemount == black then UseContainerItem(blbag, blslot)
        elseif usemount == red then UseContainerItem(rbag, rslot)
        elseif usemount == green then UseContainerItem(gbag, gslot)
        elseif usemount == yellow then UseContainerItem(ybag, yslot)
        elseif usemount == blue then UseContainerItem(bbag, bslot)
        end
    else print("Qiraji Resonating Crystals can only be used in Ahn'Qiraj Temple (AQ40)")
    end

end

-- Adds the command '/sr' which is used to summon a mount in WoW Classic.
SLASH_SR1 = "/sr"
SlashCmdList["SR"] = function(msg)
    local x = msg
    print("got here 1")
    return getMount()
end

