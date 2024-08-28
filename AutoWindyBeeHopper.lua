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
sg = game:GetService("StarterGui")
function live(m, o)
    foundNPC = o or false
    sg:SetCore("SendNotification", {
	Title = "Notification";
	Text = m..".";
	Duration = 30;
    })
end
if _G.Executed then live("Script already executed, server hopping...") hop() end
_G.Executed = true
Found = "Windy bee found"
No = "Windy bee NOT found, hopping"
f = workspace.NPCBees
if f:FindFirstChild("Windy") then
       live(Found, true)
end
f.ChildAdded:Connect(function(child)
    if child.Name == "Windy" then
        live(Found, true)
    end
end)

wait(20)
if not foundNPC then
    live(No)
    hop()
end