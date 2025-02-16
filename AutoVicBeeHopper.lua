if not game:IsLoaded() then
        game.Loaded:Wait()
end
local foundNPC
function hop()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Morples/Server-hop/main/Script"))() -- open source server hop script, I don't wanna copy and paste the entire script when I can just paste the source here
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
Found = "Vicious bee found"
No = "Vicious bee NOT found, hopping"
f = workspace.NPCBees
if f:FindFirstChild("Vicious") then
       live(Found, true)
end
f.ChildAdded:Connect(function(child)
    if child.Name == "Vicious" then
        live(Found, true)
    end
end)

task.wait(20)
if not foundNPC then
    live(No)
    hop()
end