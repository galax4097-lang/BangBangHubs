-- Simulator Helper Optimized for Solara
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Configuration
local Settings = {
    AutoClick = true,
    WalkSpeed = 100, -- Tốc độ chạy nhanh
    JumpPower = 150  -- Nhảy cao hơn
}

-- Auto Click Logic
-- Lưu ý: Mỗi game có tên RemoteEvent khác nhau. 
-- Đoạn này sẽ giả lập việc bạn nhấn chuột liên tục.
task.spawn(function()
    while true do
        if Settings.AutoClick then
            -- Cách 1: Click thông qua VirtualUser (Phổ biến cho mọi game)
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
        end
        task.wait(0.01) -- Tốc độ click (0.01 là cực nhanh)
    end
end)

-- Apply Physical Attributes
local function applyStats(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = Settings.WalkSpeed
    hum.JumpPower = Settings.JumpPower
end

applyStats(character)
player.CharacterAdded:Connect(applyStats)

print("Simulator Script Loaded! Auto-clicking is active.")
