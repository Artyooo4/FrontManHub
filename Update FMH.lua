-- Front Man Hub UI Script for Roblox Mobile Executors
-- Designed for Ronix, Arceus X, Hydrogen, and other mobile executors
-- Includes toggle button (square with glowing red X, draggable) and fly function
-- Created for educational purposes only. Use in private servers.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

-- สร้าง ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FrontManHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
print("ScreenGui Loaded") -- Debug

-- สีเรืองแสงและสไตล์
local NeonColors = {
    Primary = Color3.fromRGB(0, 255, 255), -- Cyan
    Secondary = Color3.fromRGB(255, 0, 255), -- Magenta
    Background = Color3.fromRGB(20, 20, 30), -- Dark background
    Glow = Color3.fromRGB(0, 255, 255), -- Glow effect
    ToggleGlow = Color3.fromRGB(255, 0, 0) -- Red glow for toggle button
}

-- สร้าง Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = NeonColors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
print("MainFrame Created") -- Debug

-- เพิ่มมุมโค้ง
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- เพิ่มเอฟเฟกต์เรืองแสง
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = NeonColors.Glow
UIStroke.Transparency = 0.3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- เพิ่ม Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Front Man Hub"
Title.TextColor3 = NeonColors.Primary
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.Parent = MainFrame

-- เพิ่มปุ่มตัวอย่าง
local TestButton = Instance.new("TextButton")
TestButton.Size = UDim2.new(0.8, 0, 0.15, 0)
TestButton.Position = UDim2.new(0.1, 0, 0.2, 0)
TestButton.BackgroundColor3 = NeonColors.Secondary
TestButton.Text = "Test Button"
TestButton.TextColor3 = NeonColors.Primary
TestButton.TextScaled = true
TestButton.Font = Enum.Font.SourceSansBold
TestButton.TextSize = 22
TestButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = TestButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 1.5
ButtonStroke.Color = NeonColors.Glow
ButtonStroke.Transparency = 0.3
ButtonStroke.Parent = TestButton

-- การแจ้งเตือนเมื่อกดปุ่ม
TestButton.MouseButton1Click:Connect(function()
    print("Test Button Clicked") -- Debug
    local Notification = Instance.new("TextLabel")
    Notification.Size = UDim2.new(0.3, 0, 0.1, 0)
    Notification.Position = UDim2.new(0.35, 0, 0.1, 0)
    Notification.BackgroundColor3 = NeonColors.Background
    Notification.Text = "Button Pressed!"
    Notification.TextColor3 = NeonColors.Primary
    Notification.TextScaled = true
    Notification.Font = Enum.Font.SourceSansBold
    Notification.TextSize = 20
    Notification.Parent = ScreenGui

    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Thickness = 1
    NotifStroke.Color = NeonColors.Glow
    NotifStroke.Parent = Notification

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 5)
    NotifCorner.Parent = Notification

    wait(3)
    Notification:Destroy()
end)

-- สร้างปุ่มเปิด/ปิด UI (บังคับเป็นสี่เหลี่ยมจัตุรัส)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
ToggleButton.BackgroundColor3 = NeonColors.Background
ToggleButton.Text = "X"
ToggleButton.TextColor3 = NeonColors.ToggleGlow
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.Parent = ScreenGui
print("ToggleButton Created") -- Debug

local AspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
AspectRatioConstraint.AspectRatio = 1 -- บังคับสี่เหลี่ยมจัตุรัส
AspectRatioConstraint.Parent = ToggleButton

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 5)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2
ToggleStroke.Color = NeonColors.ToggleGlow
ToggleStroke.Transparency = 0.3
ToggleStroke.Parent = ToggleButton

-- ฟังก์ชันควบคุมการเปิด/ปิด UI
local isUIVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    print("Toggle Button Clicked, UI Visible: " .. tostring(isUIVisible)) -- Debug
    isUIVisible = not isUIVisible
    MainFrame.Visible = isUIVisible
    ToggleButton.Text = isUIVisible and "X" or "O"
end)

-- ทำให้ ToggleButton ลากได้
local toggleDragging = false
local toggleDragStart = nil
local toggleStartPos = nil

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
        print("Toggle Dragging Started") -- Debug
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if toggleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - toggleDragStart
        ToggleButton.Position = UDim2.new(
            toggleStartPos.X.Scale + (delta.X / GuiService:GetScreenResolution().X),
            toggleStartPos.X.Offset,
            toggleStartPos.Y.Scale + (delta.Y / GuiService:GetScreenResolution().Y),
            toggleStartPos.Y.Offset
        )
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = false
        print("Toggle Dragging Ended") -- Debug
    end
end)

-- สร้างปุ่มบินภายใน MainFrame
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.8, 0, 0.15, 0) -- สี่เหลี่ยมใน UI หลัก
FlyButton.Position = UDim2.new(0.1, 0, 0.4, 0) -- อยู่ใต้ปุ่ม Test Button
FlyButton.BackgroundColor3 = NeonColors.Secondary
FlyButton.Text = "Fly"
FlyButton.TextColor3 = NeonColors.Primary
FlyButton.TextScaled = true
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.TextSize = 22
FlyButton.Parent = MainFrame

local FlyButtonCorner = Instance.new("UICorner")
FlyButtonCorner.CornerRadius = UDim.new(0, 8)
FlyButtonCorner.Parent = FlyButton

local FlyButtonStroke = Instance.new("UIStroke")
FlyButtonStroke.Thickness = 1.5
FlyButtonStroke.Color = NeonColors.Glow
FlyButtonStroke.Transparency = 0.3
FlyButtonStroke.Parent = FlyButton

-- ฟังก์ชันบิน
local BodyVelocity = nil
local isFlying = false

FlyButton.MouseButton1Click:Connect(function()
    print("Fly Button Clicked, Fly Status: " .. tostring(isFlying)) -- Debug
    if not isFlying then
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Parent = character.HumanoidRootPart

            isFlying = true
            FlyButton.Text = "Stop Fly"

            -- ควบคุมการบินด้วยปุ่มบนมือถือ
            local function onInput(input)
                local moveDirection = Vector3.new(0, 0, 0)
                if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then
                    moveDirection = moveDirection + Vector3.new(0, 0, -1)
                elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then
                    moveDirection = moveDirection + Vector3.new(0, 0, 1)
                elseif input.KeyCode == Enum.KeyCode.A then
                    moveDirection = moveDirection + Vector3.new(-1, 0, 0)
                elseif input.KeyCode == Enum.KeyCode.D then
                    moveDirection = moveDirection + Vector3.new(1, 0, 0)
                elseif input.KeyCode == Enum.KeyCode.Space then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                elseif input.KeyCode == Enum.KeyCode.LeftShift then
                    moveDirection = moveDirection + Vector3.new(0, -1, 0)
                end

                if BodyVelocity and isFlying then
                    BodyVelocity.Velocity = moveDirection * 50 -- ความเร็วบิน
                end
            end

            UserInputService.InputBegan:Connect(onInput)

            RunService.RenderStepped:Connect(function()
                if BodyVelocity and isFlying and character and character:FindFirstChild("HumanoidRootPart") then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        local camera = workspace.CurrentCamera
                        local direction = camera.CFrame.LookVector
                        local rightVector = camera.CFrame.RightVector
                        BodyVelocity.Velocity = Vector3.new(
                            (UserInputService:IsKeyDown(Enum.KeyCode.D) and 50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 50 or 0),
                            (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 50 or 0),
                            (UserInputService:IsKeyDown(Enum.KeyCode.W) and -50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.S) and 50 or 0)
                        )
                    end
                end
            end)
        end
    else
        if BodyVelocity then
            BodyVelocity:Destroy()
            BodyVelocity = nil
        end
        isFlying = false
        FlyButton.Text = "Fly"
    end
end)

-- ปรับ UI สำหรับมือถือ
local function OptimizeForMobile()
    if UserInputService.TouchEnabled then
        MainFrame.Size = UDim2.new(0.6, 0, 0.6, 0)
        MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
        ToggleButton.Size = UDim2.new(0.12, 0, 0.12, 0)
        ToggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
        Title.TextSize = 26
        TestButton.TextSize = 20
        FlyButton.TextSize = 20
        ToggleButton.TextSize = 22
    end
    print("Optimized for Mobile") -- Debug
end
OptimizeForMobile()

-- อนิเมชันเรืองแสง
RunService.RenderStepped:Connect(function()
    local time = tick()
    local pulse = math.sin(time * 2) * 0.1 + 0.9
    UIStroke.Transparency = 0.3 * pulse
    ButtonStroke.Transparency = 0.3 * pulse
    ToggleStroke.Transparency = 0.3 * pulse
    FlyButtonStroke.Transparency = 0.3 * pulse
end)

-- ทำให้ MainFrame ลากได้
local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        print("MainFrame Dragging Started") -- Debug
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale + (delta.X / GuiService:GetScreenResolution().X),
            startPos.X.Offset,
            startPos.Y.Scale + (delta.Y / GuiService:GetScreenResolution().Y),
            startPos.Y.Offset
        )
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        print("MainFrame Dragging Ended") -- Debug
    end
end)

-- ทำให้ ToggleButton ลากได้
local toggleDragging = false
local toggleDragStart = nil
local toggleStartPos = nil

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
        print("Toggle Dragging Started") -- Debug
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if toggleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - toggleDragStart
        ToggleButton.Position = UDim2.new(
            toggleStartPos.X.Scale + (delta.X / GuiService:GetScreenResolution().X),
            toggleStartPos.X.Offset,
            toggleStartPos.Y.Scale + (delta.Y / GuiService:GetScreenResolution().Y),
            toggleStartPos.Y.Offset
        )
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = false
        print("Toggle Dragging Ended") -- Debug
    end
end)
