-- LocalScript

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Tìm mục tiêu gần nhất
local function getClosestTarget()
    local closest = nil
    local minDist = math.huge
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closest = v
            end
        end
    end
    
    return closest
end

-- Bắn (demo)
mouse.Button1Down:Connect(function()
    local target = getClosestTarget()
    if target then
        print("Bắn vào:", target.Name)

        -- Tạo viên đạn giả
        local bullet = Instance.new("Part")
        bullet.Size = Vector3.new(0.3,0.3,2)
        bullet.CFrame = player.Character.Head.CFrame
        bullet.BrickColor = BrickColor.new("Bright red")
        bullet.Parent = workspace

        -- bay tới mục tiêu
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = (target.Character.HumanoidRootPart.Position - bullet.Position).Unit * 150
        bv.Parent = bullet

        game.Debris:AddItem(bullet, 2)
    end
end)
