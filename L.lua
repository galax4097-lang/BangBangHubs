-- LocalScript (StarterPlayerScripts)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local function getClosestPlayer()
    local closest = nil
    local shortestDistance = math.huge
    
    for _, other in pairs(game.Players:GetPlayers()) do
        if other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
            local pos = other.Character.HumanoidRootPart.Position
            local dist = (pos - player.Character.HumanoidRootPart.Position).Magnitude
            
            if dist < shortestDistance then
                shortestDistance = dist
                closest = other
            end
        end
    end
    
    return closest
end

mouse.Button1Down:Connect(function()
    local target = getClosestPlayer()
    if target then
        print("Đang nhắm tới:", target.Name)
        -- bạn có thể xử lý bắn hoặc xoay camera ở đây
    end
end)
