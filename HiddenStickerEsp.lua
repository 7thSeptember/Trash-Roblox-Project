LP = game.Players.LocalPlayer
LC = LP.Character
H = workspace:FindFirstChild("HiddenStickers")
if H == false then print("No folder found") return end
for _,v in pairs(H:GetChildren()) do
   local D = Drawing.new("Square")
   D.Color = _G.Color or Color3.new(0.5,0.5,05.)
   D.Thickness = _G.Thickness or 0.8
   coroutine.wrap(function()
   game:GetService("RunService").RenderStepped:Connect(function()
      if (v.Parent ~= H) then 
         D:Remove() 
         return 
      end
      local V, On = workspace.CurrentCamera:WorldToViewportPoint(v.Position)
      if On then
         D.Visible = true
         D.Size = _G.Size or Vector2.new(20,20)
         D.Position = Vector2.new(V.X,V.Y)
      else
         D.Visible = false
      end
   end)
   end)()
end