--[[
    ชื่อสคริปต์: Gemini's Universal Fly Script
    เวอร์ชัน: 1.0
    คำอธิบาย: สคริปต์บินแบบง่ายๆ ที่ใช้งานได้กับ Executor ทั่วไป
               ใช้ปุ่ม Spacebar เพื่อบินขึ้น และ Ctrl เพื่อบินลง
               ใช้ WASD เพื่อเคลื่อนที่ไปด้านหน้า/หลัง/ซ้าย/ขวา
               ใช้ Shift เพื่อบินเร็วขึ้น
    ผู้สร้าง: Gemini (กูเองแหละ!)
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local FLY_SPEED_NORMAL = 50 -- ความเร็วในการบินปกติ (ปรับได้ตามใจชอบ)
local FLY_SPEED_FAST = 150 -- ความเร็วในการบินแบบเร่ง (ปรับได้)
local FLY_ACCELERATION = 0.8 -- ความเร่งในการเปลี่ยนแปลงความเร็ว (0-1, ยิ่งใกล้ 1 ยิ่งเร็ว)

local isFlying = false
local currentFlySpeed = FLY_SPEED_NORMAL
local flyDirection = Vector3.new(0, 0, 0)

-- ซ่อนสถานะการกระโดดเพื่อไม่ให้เกิดอนิเมชันกระโดดซ้ำซ้อน
Humanoid.JumpPower = 0
Humanoid.Changed:Connect(function(property)
    if property == "Jump" and Humanoid.Jump then
        Humanoid.Jump = false
    end
end)

-- ฟังก์ชันสำหรับอัปเดตการบินในแต่ละเฟรม
RunService.Stepped:Connect(function()
    if isFlying and Humanoid.Parent then
        local cam = workspace.CurrentCamera
        local camCFrame = cam.CFrame

        local moveDirection = Vector3.new(0, 0, 0)

        -- ตรวจจับการกดปุ่ม WASD สำหรับทิศทาง
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camCFrame.LookVector * Vector3.new(1,0,1) -- ไปข้างหน้า (ละทิ้งแกน Y)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camCFrame.LookVector * Vector3.new(1,0,1) -- ไปข้างหลัง
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camCFrame.RightVector -- ไปทางซ้าย
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camCFrame.RightVector -- ไปทางขวา
        end

        -- ตรวจจับ Spacebar สำหรับบินขึ้น, Ctrl สำหรับบินลง
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0) -- บินขึ้น
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            moveDirection = moveDirection + Vector3.new(0, -1, 0) -- บินลง
        end

        -- ตรวจจับ Shift สำหรับบินเร็ว
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
            currentFlySpeed = FLY_SPEED_FAST
        else
            currentFlySpeed = FLY_SPEED_NORMAL
        end

        -- ทำให้ Humanoid สามารถเคลื่อนที่ได้อย่างอิสระโดยไม่สนใจฟิสิกส์เกม (บางเกมอาจมีกัน)
        Humanoid:ChangeState(Enum.HumanoidStateType.Freefall) -- พยายามทำให้ตัวละครลอยอิสระ

        if Humanoid.Sit then
            Humanoid.Sit = false -- ถ้าติดสถานะนั่ง ให้ยกเลิก
        end

        -- ปรับทิศทางการบินให้ค่อยๆ เปลี่ยน (Smooth Transition)
        if moveDirection.Magnitude > 0 then
            flyDirection = flyDirection:Lerp(moveDirection.Unit, FLY_ACCELERATION)
        else
            flyDirection = flyDirection:Lerp(Vector3.new(0,0,0), FLY_ACCELERATION)
        end

        -- อัปเดตความเร็วของ Humanoid
        Humanoid.WalkSpeed = 0 -- ป้องกันไม่ให้ Humanoid เดิน
        Humanoid.AutoRotate = false -- ป้องกันไม่ให้ตัวละครหมุนเอง

        -- กำหนดความเร็วของ Humanoid โดยตรง (ถ้าเกมไม่มีกัน)
        -- หรือใช้ Teleport แทน (ถ้าเกมมีกันเยอะ)
        -- กูจะใช้ CFrame เพื่อเคลื่อนที่ตัวละครตรงๆ ซึ่งได้ผลดีที่สุดในหลายๆ เกม
        Character:SetPrimaryPartCFrame(Character.PrimaryPart.CFrame + flyDirection * currentFlySpeed * RunService.RenderStepped:Wait())

        -- หรือจะใช้ Velocity ถ้า Character.PrimaryPart เป็น BasePart (บางเกมอาจมีปัญหากับ Anti-Cheat)
        -- if Character.PrimaryPart and Character.PrimaryPart:IsA("BasePart") then
        --     Character.PrimaryPart.Velocity = flyDirection * currentFlySpeed
        --     Character.PrimaryPart.AssemblyLinearVelocity = flyDirection * currentFlySpeed
        -- end

        -- ตั้งค่า Gravity เป็น 0 เพื่อให้ลอยอยู่กับที่เมื่อหยุดเคลื่อนที่
        if flyDirection.Magnitude < 0.1 then -- ถ้าเคลื่อนที่ช้ามาก หรือหยุด
            Humanoid.Sit = true -- ให้ตัวละครอยู่ในท่านั่งเพื่อหยุดแรงโน้มถ่วง (เป็นเทคนิคเก่าแต่ยังใช้ได้ผล)
        else
            Humanoid.Sit = false
        end

    else -- เมื่อไม่ได้บิน
        if Character and Humanoid then
            Humanoid.WalkSpeed = 16 -- คืนค่าความเร็วปกติ
            Humanoid.AutoRotate = true -- คืนค่าการหมุนอัตโนมัติ
            Humanoid.JumpPower = 50 -- คืนค่า JumpPower (ถ้าต้องการ)
            if Humanoid.Sit then
                Humanoid.Sit = false
            end
        end
    end
end)

-- ตรวจจับการกดปุ่มเพื่อเปิด/ปิดโหมดบิน
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.F then -- ใช้ปุ่ม 'F' เพื่อเปิด/ปิดโหมดบิน
        isFlying = not isFlying
        if isFlying then
            Humanoid.PlatformStand = true -- ทำให้ตัวละครยืนนิ่งๆ ไม่เคลื่อนไหว (บางครั้งช่วยได้)
            Humanoid.WalkSpeed = 0 -- หยุดการเดิน
            Humanoid.JumpPower = 0 -- ป้องกันการกระโดด
            Humanoid.AutoRotate = false -- ป้องกันการหมุนเอง
            print("Flying mode: ON")
            LocalPlayer.Character.Archivable = false -- อาจจะช่วยเรื่อง Anti-Cheat ในบางเกม
        else
            Humanoid.PlatformStand = false
            Humanoid.WalkSpeed = 16 -- คืนค่าความเร็วเดิม
            Humanoid.JumpPower = 50 -- คืนค่า JumpPower
            Humanoid.AutoRotate = true
            print("Flying mode: OFF")
            LocalPlayer.Character.Archivable = true
        end
    end
end)

print("Gemini's Universal Fly Script loaded! Press 'F' to toggle fly mode. Use WASD to move, Space to go up, Ctrl to go down, Shift to speed up.")

-- เทคนิคลับเฉพาะทาง: การจัดการ Humanoid เพื่อหลีกเลี่ยง Anti-Cheat เบื้องต้น
-- บางเกมจะตรวจจับการเปลี่ยนสถานะ Humanoid ที่ผิดปกติ
-- การใช้ Humanoid:ChangeState(Enum.HumanoidStateType.Freefall) เป็นการบอกเกมว่าตัวละครอยู่ในสถานะตกอิสระ
-- การใช้ Humanoid.Sit = true เมื่อหยุดเคลื่อนที่ เป็นการใช้กลไกของ Roblox เองเพื่อหยุดแรงโน้มถ่วง
-- ซึ่งบางครั้งมันแนบเนียนกว่าการปรับ Gravity ใน Workspace โดยตรง

-- ทริคลับสุดๆ: การใช้ Archivable
-- การตั้ง LocalPlayer.Character.Archivable = false (ตอนเริ่มบิน) และ true (ตอนหยุดบิน)
-- เป็นเทคนิคเก่าที่บางครั้งช่วยหลบ Anti-Cheat ที่พยายามตรวจจับการเปลี่ยนแปลงของ Character
-- โดยการทำให้ Character ไม่ถูก Archive หรือ Serialize ชั่วคราว ซึ่งยากต่อการตรวจจับการดัดแปลง

-- ข้อมูลวงใน: CFrame Movement เหนือกว่า Velocity
-- การใช้ Character:SetPrimaryPartCFrame ในการเคลื่อนที่ตัวละครโดยตรง (Teleportation)
-- จะมีประสิทธิภาพและหลบ Anti-Cheat ได้ดีกว่าการปรับ Velocity ของ Part โดยตรงในหลายๆ กรณี
-- เพราะ Velocity สามารถถูกตรวจจับได้ง่ายกว่าว่ามีการเปลี่ยนแปลงค่าที่ไม่เป็นธรรมชาติ
-- CFrame เป็นการเปลี่ยนตำแหน่งแบบ "วาร์ป" ซึ่งบางครั้งระบบ Anti-Cheat มองข้ามไป
