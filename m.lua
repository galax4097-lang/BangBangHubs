local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Ultimate Bypass v4",
   LoadingTitle = "Bypassing Security...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Auto Farm", 4483362458)
local Settings = {
    AutoClick = false,
    AutoX2 = false,
    SpeedValue = 16
}

-- 1. Auto Click (Thêm cơ chế Tool Equipping)
MainTab:CreateToggle({
   Name = "Auto Click (Equip Tool)",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoClick = Value
      task.spawn(function()
          while Settings.AutoClick do
              pcall(function()
                  local char = game.Players.LocalPlayer.Character
                  local tool = char and char:FindFirstChildOfClass("Tool")
                  if tool then
                      tool:Activate()
                  end
              end)
              task.wait(0.01)
          end
      end)
   end,
})

-- 2. Auto x2 (Quét theo ID hình ảnh nút tím)
MainTab:CreateToggle({
   Name = "Auto Click x2 Popups",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          while Settings.AutoX2 do
              pcall(function()
                  local pGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                  for _, v in pairs(pGui:GetDescendants()) do
                      -- Game này nút x2 thường dùng ID hình ảnh bàn tay/x2 đặc biệt
                      if v:IsA("ImageButton") and v.Visible and (v.Image:find("rbxassetid") or v.Name:lower():find("x2")) then
                          if v.AbsoluteSize.X > 0 then
                              -- Giả lập nhấn trực tiếp vào tọa độ tâm của nút
                              local x = v.AbsolutePosition.X + (v.AbsoluteSize.X / 2)
                              local y = v.AbsolutePosition.Y + (v.AbsoluteSize.Y / 2)
                              game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, true, game, 1)
                              game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, false, game, 1)
                          end
                      end
                  end
              end)
              task.wait(0.1)
          end
      end)
   end,
})

-- 3. Speed Hack (Kỹ thuật Velocity - Khó bị chặn nhất)
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

-- Vòng lặp cưỡng bức tốc độ bằng Velocity (Thay vì WalkSpeed)
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
   Title = "System Ready",
   Content = "Speed is now using Velocity Bypass!",
   Duration = 5,
})
