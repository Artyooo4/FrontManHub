-- Front Man Hub UI Script for Roblox Mobile Executors
-- Designed for Ronix, Arceus X, Hydrogen, and other mobile executors
-- No external library required, uses Roblox native UI system
-- Created for educational purposes only. Use in private servers.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FrontManHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- สีเรืองแสงและสไตล์
local NeonColors = {
    Primary = Color3.fromRGB(0, 255, 255), -- Cyan
    Secondary = Color3.fromRGB(255, 0, 255), -- Magenta
    Background = Color3.fromRGB(20, 20, 30), -- Dark background
    Glow = Color3.fromRGB(0, 255, 255) -- Glow effect
}

-- สร้าง Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = NeonColors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- เพิ่มมุมโค้ง (Corner Radius)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- เพิ่มเอฟเฟกต์เรืองแสงด้วย UIStroke
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
Title.Font = Enum.Font.FredokaOne
Title.Parent = MainFrame

-- เพิ่มปุ่มตัวอย่าง
local TestButton = Instance.new("TextButton")
TestButton.Size = UDim2.new(0.8, 0, 0.15, 0)
TestButton.Position = UDim2.new(0.1, 0, 0.2, 0)
TestButton.BackgroundColor3 = NeonColors.Secondary
TestButton.Text = "Test Button"
TestButton.TextColor3 = NeonColors.Primary
TestButton.TextScaled = true
TestButton.Font = Enum.Font.FredokaOne
TestButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = TestButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 1.5
ButtonStroke.Color = NeonColors.Glow
ButtonStroke.Transparency = 0.3
ButtonStroke.Parent = TestButton

-- เพิ่มการแจ้งเตือนเมื่อกดปุ่ม
TestButton.MouseButton1Click:Connect(function()
    local Notification = Instance.new("TextLabel")
    Notification.Size = UDim2.new(0.3, 0, 0.1, 0)
    Notification.Position = UDim2.new(0.35, 0, 0.1, 0)
    Notification.BackgroundColor3 = NeonColors.Background
    Notification.Text = "Button Pressed!"
    Notification.TextColor3 = NeonColors.Primary
    Notification.TextScaled = true
    Notification.Font = Enum.Font.FredokaOne
    Notification.Parent = ScreenGui

    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Thickness = 1
    NotifStroke.Color = NeonColors.Glow
    NotifStroke.Parent = Notification

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 5)
    NotifCorner.Parent = Notification

    -- ลบการแจ้งเตือนหลัง 3 วินาที
    wait(3)
    Notification:Destroy()
end)

-- ปรับ UI สำหรับมือถือ
local function OptimizeForMobile()
    if UserInputService.TouchEnabled then
        MainFrame.Size = UDim2.new(0.6, 0, 0.6, 0) -- ขยายสำหรับหน้าจอมือถือ
        MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
        Title.TextSize = 24
        TestButton.TextSize = 20
    end
end
OptimizeForMobile()

-- เพิ่มอนิเมชันเรืองแสง
game:GetService("RunService").RenderStepped:Connect(function()
    local time = tick()
    local pulse = math.sin(time * 2) * 0.1 + 0.9
    UIStroke.Transparency = 0.3 * pulse
    ButtonStroke.Transparency = 0.3 * pulse
end)

-- ทำให้ UI ลากได้ (Draggable)
local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale + (delta.X / game:GetService("GuiService"):GetScreenResolution().X),
            startPos.X.Offset,
            startPos.Y.Scale + (delta.Y / game:GetService("GuiService"):GetScreenResolution().Y),
            startPos.Y.Offset
        )
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
