-- LocalScript

local player = game.Players.LocalPlayer

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "MyHub"
gui.Parent = player:WaitForChild("PlayerGui")

-- Frame chính
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 250)
main.Position = UDim2.new(0.5, -200, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Parent = gui

-- Bo góc
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 12)

-- Shadow giả
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.7
shadow.Parent = main

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🔥 My Hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = main

-- Nút
local function createButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Parent = main

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    -- Hiệu ứng hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    return btn
end

-- Tạo các nút
local btn1 = createButton("Auto Aim (Demo)", 60)
local btn2 = createButton("Speed Boost", 110)
local btn3 = createButton("Close", 160)

-- Chức năng demo
btn1.MouseButton1Click:Connect(function()
    print("Bật Auto Aim (demo thôi)")
end)

btn2.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 50
end)

btn3.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
