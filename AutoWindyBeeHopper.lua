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
local rs = game:GetService("RunService")
local c = game.CurrentCamera
function live(o)
    local Square = Drawing.new("Square")
    Square.Thickness = 0.5
    Square.Size = _G.WSize or Vector2.new(20,20)
    RS.RenderStepped:connect(function()
       local V, On = c:WorldToViewportPoint(o.Position)
       if On then
           Square.Visible = true
           Square.Position = V
       else
           Square.Visible = false
       end
    end)
end

workspace.NPCBees.ChildAdded:Connect(function(child) --credits to trans for this
    task.wait(0.33)
    if child.Name == "Windy" then
        foundNPC = true
        local S,F = pcall(function()
        live(workspace.NPCBees.Windy)
        end)
    end
end)

task.wait(5)
if not foundNPC then
    hop()
end
