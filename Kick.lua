local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Simulator Pro v2",
   LoadingTitle = "Fixing System Errors...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Farm", 4483362458)
local Settings = {
    AutoClick = false,
    AutoX2 = false,
    WalkSpeed = 16
}

-- 1. Auto Click (Force Active)
MainTab:CreateToggle({
   Name = "Auto Click (Equip Tool)",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoClick = Value
      task.spawn(function()
          while Settings.AutoClick do
              local char = game.Players.LocalPlayer.Character
              if char and char:FindFirstChildOfClass("Tool") then
                  char:FindFirstChildOfClass("Tool"):Activate()
              end
              task.wait(0.01)
          end
      end)
   end,
})

-- 2. Auto Click x2 (Deep Scan)
MainTab:CreateToggle({
   Name = "Auto Click x2 Popups",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          while Settings.AutoX2 do
              local pGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
              for _, obj in pairs(pGui:GetDescendants()) do
                  -- Tìm nút màu tím hoặc nút có hình Click chuột
                  if (obj:IsA("ImageButton") or obj:IsA("TextButton")) and obj.Visible then
                      if obj.Name:lower():find("click") or obj.Name:lower():find("x2") or obj.AbsoluteSize.X > 50 then
                          pcall(function()
                              -- Nhấn mạnh hơn bằng cách gọi trực tiếp hàm xử lý của game
                              obj:Activate()
                              for _, con in pairs(getconnections(obj.MouseButton1Click)) do con:Fire() end
                          end)
                      end
                  end
              end
              task.wait(0.1) -- Quét nhanh hơn nữa
          end
      end)
   end,
})

-- 3. WalkSpeed Fix (Looping Force)
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "Force WalkSpeed",
   Range = {16, 500},
   Increment = 10,
   CurrentValue = 16,
   Callback = function(Value)
      Settings.WalkSpeed = Value
   end,
})

-- Vòng lặp này cực kỳ quan trọng: Nó ép game không được reset tốc độ
task.spawn(function()
    while true do
        pcall(function()
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= Settings.WalkSpeed then
                hum.WalkSpeed = Settings.WalkSpeed
            end
        end)
        task.wait(0.1)
    end
end)

Rayfield:Notify({
   Title = "System Updated",
   Content = "Speed and x2 Click are now FORCED.",
   Duration = 5,
})
