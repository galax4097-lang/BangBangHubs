local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Ultimate Bypass v6",
   LoadingTitle = "Optimizing System...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Tự Động Farm", 4483362458)
local Settings = {
    AutoX2 = false,
    SpeedValue = 16
}

-- 1. Auto Hunt x2 Bonus Popups (Tự Động Săn Nút X2 Thưởng)
-- This feature is redesigned for PC and Solara to perfectly click the popup in real-time.
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
                  -- Deep scan for the unique popup button
                  for _, v in pairs(pGui:GetDescendants()) do
                      -- Check for an visible ImageButton with specific characteristics
                      -- Looking for specific name patterns like "Popup" or unique image asset
                      if (v:IsA("ImageButton") or v:IsA("TextButton")) and v.Visible and (v.Name:lower():find("pop") or v.Name:lower():find("bonus") or v.Image:find("rbxassetid") or v.Image:find("click")) then
                          if v.AbsoluteSize.X > 0 and v.Active then
                              -- PC Title Bar Correction: Standard is around 36px. We use 36.
                              -- If it doesn't click, try changing +36 to other values like +30 or +40.
                              local centerX = v.AbsolutePosition.X + (v.AbsoluteSize.X / 2)
                              local centerY = v.AbsolutePosition.Y + (v.AbsoluteSize.Y / 2) + 36 -- +36 to account for PC title bar
                              
                              -- Simulate a perfect MouseClick event to bypass protection
                              vim:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                              vim:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                          end
                      end
                  end
              end)
              task.wait(0.01) -- High-speed scan for popups
          end
      end)
   end,
})

-- 2. Miscellaneous (Chức Năng Khác)
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "Custom WalkSpeed",
   Range = {16, 500},
   Increment = 10,
   CurrentValue = 16,
   Callback = function(Value)
      Settings.SpeedValue = Value
   end,
})

-- Force Velocity Bypass (Keep the working speed hack)
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
   Title = "System Injection Successful",
   Content = "Speed is working. Now, start farming!",
   Duration = 5,
})
