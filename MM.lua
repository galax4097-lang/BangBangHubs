local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Bonus Hunter v5",
   LoadingTitle = "Optimizing for Simulator...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Auto Farm", 4483362458)
local Settings = {
    AutoX2 = false,
    SpeedValue = 16
}

-- 1. Auto Click x2 Bonus (The core feature)
MainTab:CreateToggle({
   Name = "Auto Click x2 Popups",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          local vim = game:GetService("VirtualInputManager")
          while Settings.AutoX2 do
              pcall(function()
                  local pGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                  for _, obj in pairs(pGui:GetDescendants()) do
                      -- Quét các ImageButton đang hiện trên màn hình
                      -- Thường các nút x2 bonus này sẽ không nằm trong các bảng Menu tĩnh
                      if obj:IsA("ImageButton") and obj.Visible and obj.Active then
                          -- Kiểm tra điều kiện: Nút phải có kích thước hợp lý và thường có Image rbxassetid
                          if obj.AbsoluteSize.X > 20 and obj.AbsoluteSize.X < 200 then
                              -- Lấy tọa độ tâm của nút x2
                              local centerX = obj.AbsolutePosition.X + (obj.AbsoluteSize.X / 2)
                              local centerY = obj.AbsolutePosition.Y + (obj.AbsoluteSize.Y / 2) + 36 -- +36 để bù trừ thanh tiêu đề Roblox
                              
                              -- Giả lập một cú chạm chuột thật sự vào đúng vị trí đó
                              vim:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                              vim:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                          end
                      end
                  end
              end)
              task.wait(0.1) -- Tốc độ quét cực nhanh để nút hiện ra là mất ngay
          end
      end)
   end,
})

-- 2. Movement (The working Speed Hack)
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "Custom Speed",
   Range = {16, 500},
   Increment = 10,
   CurrentValue = 16,
   Callback = function(Value)
      Settings.SpeedValue = Value
   end,
})

-- Vòng lặp cưỡng bức Velocity (Giữ nguyên phần Speed đã hoạt động tốt)
game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.Velocity = Vector3.new(hum.MoveDirection.X * Settings.SpeedValue, hrp.Velocity.Y, hum.MoveDirection.Z * Settings.SpeedValue)
        end
    end)
end)

Rayfield:Notify({
   Title = "BangBangHub Loaded",
   Content = "Speed is OK. Auto x2 Hunter is Ready!",
   Duration = 5,
})
