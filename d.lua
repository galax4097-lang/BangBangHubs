-- LocalScript (StarterPlayerScripts)

local player = game.Players.LocalPlayer

-- GUI chính
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BladeBallHub"

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "⚔️ Blade Ball Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Tabs
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(0,120,1,-40)
tabFrame.Position = UDim2.new(0,0,0,40)
tabFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)

-- Content
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-120,1,-40)
content.Position = UDim2.new(0,120,0,40)
content.BackgroundTransparency = 1

-- Tab Button function
local function createTab(name, posY)
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(1,0,0,40)
    btn.Position = UDim2.new(0,0,0,posY)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    return btn
end

-- Tabs
local combatTab = createTab("Combat", 0)
local playerTab = createTab("Player", 40)

-- Clear content
local function clearContent()
    for _,v in pairs(content:GetChildren()) do
        v:Destroy()
    end
end

-- Toggle function
local function createToggle(text, posY, callback)
    local btn = Instance.new("TextButton", content)
    btn.Size = UDim2.new(0.8,0,0,40)
    btn.Position = UDim2.new(0.1,0,0,posY)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.new(1,1,1)

    local state = false

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        callback(state)
    end)
end

-- BUTTON function
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton", content)
    btn.Size = UDim2.new(0.8,0,0,40)
    btn.Position = UDim2.new(0.1,0,0,posY)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)

    btn.MouseButton1Click:Connect(callback)
end

--------------------------------------------------
-- Combat Tab
combatTab.MouseButton1Click:Connect(function()
    clearContent()

    createToggle("Auto Parry (demo)", 0, function(state)
        print("Auto Parry:", state)
    end)

    createToggle("Auto Track Ball", 50, function(state)
        print("Tracking:", state)
    end)

    createButton("Hit Ball", 100, function()
        print("Đánh bóng!")
    end)
end)

--------------------------------------------------
-- Player Tab
playerTab.MouseButton1Click:Connect(function()
    clearContent()

    createToggle("Speed Boost", 0, function(state)
        if state then
            player.Character.Humanoid.WalkSpeed = 50
        else
            player.Character.Humanoid.WalkSpeed = 16
        end
    end)

    createButton("Reset", 50, function()
        player.Character:BreakJoints()
    end)
end)

-- Load mặc định
combatTab:Fire()
