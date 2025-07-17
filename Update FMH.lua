-- Fly Script by Grok (Custom for Roblox)
-- รันใน Executor เช่น Krnl, Fluxus, Delta
-- ควบคุม: กด E เพื่อเปิด/ปิดการบิน, ใช้ WASD หรือเมาส์ควบคุมทิศทาง

local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ตัวแปรสำหรับการบิน
local flying = false
local bodyVelocity = nil
local bodyGyro = nil
local speed = 50 -- ความเร็วการบิน (ปรับได้)
local maxSpeed = 100 -- ความเร็วสูงสุด

-- ฟังก์ชันเริ่มการบิน
local function startFlying()
    if flying then return end
    flying = true
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart

    -- สร้าง BodyVelocity เพื่อควบคุมการเคลื่อนที่
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

    -- สร้าง BodyGyro เพื่อควบคุมทิศทาง
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.P = 3000
    bodyGyro.D = 500
    bodyGyro.Parent = rootPart

    print("Flight Enabled!")
end

-- ฟังก์ชันหยุดการบิน
local function stopFlying()
    if not flying then return end
    flying = false
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    print("Flight Disabled!")
end

-- ฟังก์ชันควบคุมการบิน
local function updateFlight()
    if not flying then return end
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        stopFlying()
        return
    end
    local rootPart = character.HumanoidRootPart
    local camera = game.Workspace.CurrentCamera
    local direction = Vector3.new(0, 0, 0)

    -- ควบคุมทิศทางด้วย WASD หรือปุ่ม
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        direction = direction + camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        direction = direction - camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        direction = direction - camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        direction = direction + camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        direction = direction + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        direction = direction - Vector3.new(0, 1, 0)
    end

    -- อัปเดตความเร็วและทิศทาง
    bodyVelocity.Velocity = direction * speed
    bodyGyro.CFrame = camera.CFrame
end

-- ตรวจจับการกดปุ่ม E เพื่อเปิด/ปิดการบิน
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end)

-- อัปเดตการบินทุกเฟรม
RunService.RenderStepped:Connect(updateFlight)

-- ป้องกันการตายแล้วสคริปต์ค้าง
Player.CharacterAdded:Connect(function()
    stopFlying()
end)

print("Fly Script Loaded! Press E to toggle flying.")
