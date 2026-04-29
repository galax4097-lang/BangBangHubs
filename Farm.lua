local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BangBangHub | Simulator Pro",
   LoadingTitle = "Đang tải giao diện...",
   LoadingSubtitle = "by Gemini 3",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Tự Động Farm", 4483362458) -- Icon ID

local Settings = {
    AutoClick = false,
    AutoX2 = false,
    Speed = 16
}

-- Tính năng Auto Click
MainTab:CreateToggle({
   Name = "Auto Click (Cầm tạ trên tay)",
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

-- Tính năng Tự động nhấn nút x2 (Săn nút ngẫu nhiên)
MainTab:CreateToggle({
   Name = "Auto Click Nút x2 Xuất Hiện",
   CurrentValue = false,
   Callback = function(Value)
      Settings.AutoX2 = Value
      task.spawn(function()
          while Settings.AutoX2 do
              local pGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
              for _, obj in pairs(pGui:GetDescendants()) do
                  if (obj:IsA("ImageButton") or obj:IsA("TextButton")) and obj.Visible then
                      -- Tự động kích hoạt nút nếu nó đang hiện ra
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

local MiscTab = Window:CreateTab("Tiện ích", 4483362458)

MiscTab:CreateSlider({
   Name = "Tốc độ chạy",
   Range = {16, 300},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

Rayfield:Notify({
   Title = "Thành công!",
   Content = "Chúc bạn chơi game vui vẻ",
   Duration = 5,
})
