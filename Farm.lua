-- Auto Click Random Popups (x2 Events)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Cấu hình
local Settings = {
    Enabled = true,
    CheckInterval = 0.5 -- Kiểm tra mỗi 0.5 giây để đỡ lag
}

print("Auto Event Clicker đã kích hoạt! Đang săn nút x2...")

task.spawn(function()
    while task.wait(Settings.CheckInterval) do
        if Settings.Enabled then
            -- Quét toàn bộ giao diện màn hình
            local guiObjects = pGui:GetDescendants()
            
            for _, obj in pairs(guiObjects) do
                -- Kiểm tra xem có phải là Nút bấm (ImageButton hoặc TextButton) không
                if (obj:IsA("ImageButton") or obj:IsA("TextButton")) then
                    
                    -- Điều kiện: Nút đó phải đang HIỆN (Visible) 
                    -- và thường các nút x2 sẽ có tên hoặc chứa hình ảnh đặc biệt
                    -- Mình sẽ ưu tiên click các nút bất ngờ hiện lên
                    if obj.Visible and obj.Active and obj.AbsoluteSize.X > 0 then
                        
                        -- Bạn có thể thêm điều kiện tên nút ở đây nếu biết
                        -- Ví dụ: if obj.Name == "ClickMe" then ...
                        
                        -- Tự động giả lập nhấn vào nút đó
                        local events = {"MouseButton1Click", "MouseButton1Down", "Activated"}
                        for _, eventName in pairs(events) do
                            if obj[eventName] then
                                -- Kích hoạt tất cả các sự kiện nhấn của nút
                                for _, connection in pairs(getconnections(obj[eventName])) do
                                    connection:Fire()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
