local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Ultimate v3",
   LoadingTitle = "Bypassing Game Protection...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Farm", 4483362458)
local Settings = {
    AutoClick = false,
    AutoX2 = false,
    WalkSpeed = 16
}

-- 1. Auto Click (Thêm lệnh Click chuột ảo)
MainTab:CreateToggle({
   Name = "Auto Click (Equip Tool)",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoClick = Value
      task.spawn(function()
          local VirtualUser = game:GetService("VirtualUser")
          while Settings.AutoClick do
              pcall(function()
                  local char = game.Players.LocalPlayer.Character
                  if char and char:FindFirstChildOfClass("Tool") then
                      char:FindFirstChildOfClass("Tool"):Activate()
                  end
                  -- Giả lập click chuột thật vào giữa màn hình
                  VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
              end)
              task.wait(0.01)
          end
      end)
   end,
})

-- 2. Auto Click x2 (Quét theo hình ảnh nút)
MainTab:CreateToggle({
   Name = "Auto Click x2 Popups",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          while Settings.AutoX2 do
              local pGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
              if pGui then
                  for _, obj in pairs(pGui:GetDescendants()) do
                      -- Game này nút x2 thường là ImageButton có hình bàn tay
                      if obj:IsA("ImageButton") and obj.Visible and obj.Image:find("http") then
                          pcall(function()
                              -- Nhấn bằng nhiều cách cùng lúc để đảm bảo trúng
                              obj:Activate()
                              for _, con in pairs(getconnections(obj.MouseButton1Click)) do con:Fire() end
                              for _, con in pairs(getconnections(obj.Activated)) do con:Fire() end
                          end)
                      end
                  end
              end
              task.wait(0.2)
          end
      end)
   end,
})

-- 3. Speed Hack (Dùng kỹ thuật ghi đè CFrame nếu WalkSpeed bị chặn)
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "Speed Multiplier",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value)
      Settings.WalkSpeed = Value
   end,
})

-- Vòng lặp cưỡng bức di chuyển (CFrame Speed)
task.spawn(function()
    local RunService = game:GetService("RunService")
    RunService.RenderStepped:Connect(function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 and Settings.WalkSpeed > 1 then
                -- Nếu WalkSpeed bị game chặn, mình sẽ đẩy nhân vật đi bằng tọa độ (CFrame)
                char:TranslateBy(hum.MoveDirection * (Settings.WalkSpeed / 5))
            end
        end)
    end)
end)

Rayfield:Notify({
   Title = "System Injected",
   Content = "If Speed doesn't work, try jumping!",
   Duration = 5,
})
