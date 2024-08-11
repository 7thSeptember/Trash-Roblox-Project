local placeID = game.PlaceId
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local foundNPC = false

local function hop()
    local success, site = pcall(function()
        return httpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeID .. '/servers/Public?sortOrder=Asc&limit=100'))
    end)
    
    if not success or not site or not site.data then
        return
    end
    
    local foundServer = false
    for _, serverData in pairs(site.data) do
        if serverData.maxPlayers > serverData.playing then
            local serverID = tostring(serverData.id)
            local success, _ = pcall(function()
                teleportService:TeleportToPlaceInstance(placeID, serverID, game.Players.LocalPlayer)
            end)
            if success then
                foundServer = true
                break
            end
        end
    end
end

workspace.NPCBees.ChildAdded:Connect(function(child) --credits to trans for this
    task.wait(0.33)
    if child.Name == "Windy" then
        foundNPC = true
    end
end)

task.wait(5)
if not foundNPC then
    hop()
end
