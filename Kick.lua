local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Simulator Pro",
   LoadingTitle = "Loading System...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Farm", 4483362458)

local Settings = {
    AutoClick = false,
    AutoX2 = false
}

-- 1. Auto Click (Main Feature)
MainTab:CreateToggle({
   Name = "Auto Click (Equip Tool)",
   CurrentValue = false,
   Flag = "AutoClick", 
   Callback = function(Value)
      Settings.AutoClick = Value
      task.spawn(function()
          while Settings.AutoClick do
              local char = game.Players.LocalPlayer.Character
              if char then
                  local tool = char:FindFirstChildOfClass("Tool")
                  if tool then 
                      tool:Activate() 
                  end
              end
              task.wait(0.01) -- High speed click
          end
      end)
   end,
})

-- 2. Auto Click x2 Popups (The Purple Button in your screenshot)
MainTab:CreateToggle({
   Name = "Auto Click x2 Popups",
   CurrentValue = false,
   Flag = "AutoX2",
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          while Settings.AutoX2 do
              local pGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
              -- Scans all UI for the x2 Button
              for _, obj in pairs(pGui:GetDescendants()) do
                  if (obj:IsA("ImageButton") or obj:IsA("TextButton")) and obj.Visible then
                      -- If the button is on screen, click it
                      if obj.AbsoluteSize.X > 0 and obj.AbsolutePosition.Y > 0 then
                          pcall(function()
                              obj:Activate() -- Virtual click
                          end)
                      end
                  end
              end
              task.wait(0.3) -- Scanning speed
          end
      end)
   end,
})

-- 3. Character Utilities
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 10,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then
          hum.WalkSpeed = Value
      end
   end,
})

-- Notification when loaded
Rayfield:Notify({
   Title = "BangBangHub Ready",
   Content = "Toggle the buttons to start farming!",
   Duration = 5,
})
