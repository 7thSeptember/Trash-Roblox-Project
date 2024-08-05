RS = game:GetService("RunService")
C = workspace.CurrentCamera
LP = game.Players.LocalPlayer
LC = LP.Character
H = workspace:FindFirstChild("HiddenStickers")
if H == false then print("No folder found") return end

for _,v in pairs(H:GetChildren()) do
   local D = Drawing.new("Square")
   D.Color = Color3.new(0.5,0.5,05.)
   D.Thickness = 0.8
   live(D)
   coroutine.wrap(
   RS.RenderStepped:Connect(function()
      if D.Parent ~= H then D:Remove() return end
      local V, On = C:WorldToViewportPoint(v.Position)
      if On then
         D.Visible = true
         D.Size = Vector2.new(40,40)
         D.Position = Vector2.new((V.X-0.5),(V.Y-0.5))
      else
         D.Visible = false
      end
   end)()
  end
