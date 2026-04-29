local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Simulator Pro",
   LoadingTitle = "Loading Interface...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Farm", 4483362458)

local Settings = {
    AutoClick = false,
    AutoX2 = false,
    Speed = 16
}

-- Auto Click Feature
MainTab:CreateToggle({
   Name = "Auto Click (Equip Tool)",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoClick = Value
      task.spawn(function()
          while Settings.AutoClick do
              local char = game.Players.LocalPlayer.Character
              if char then
                  local tool = char:FindFirstChildOfClass("Tool")
                  if tool then tool:Activate() end
              end
              task.wait(0.01)
          end
      end)
   end,
})

-- Auto Click Random x2 Buttons
MainTab:CreateToggle({
   Name = "Auto Click x2 Popups",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          while Settings.AutoX2 do
              local pGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
              for _, obj in pairs(pGui:GetDescendants()) do
                  if (obj:IsA("ImageButton") or obj:IsA("TextButton")) and obj.Visible then
                      pcall(function()
                          if obj.AbsoluteSize.X > 0 then
                              obj:Activate()
                          end
                      end)
                  end
              end
              task.wait(0.5)
          end
      end)
   end,
})

local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 10,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

Rayfield:Notify({
   Title = "Script Loaded!",
   Content = "Enjoy your game with BangBangHub",
   Duration = 5,
})
