-- สคริปต์ LocalScript สำหรับรันใน Ronix
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- ตรวจสอบว่า LocalPlayer มีอยู่
local player = Players.LocalPlayer
if not player then
    warn("Error: LocalPlayer not found!")
    return
end

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HeadUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- สร้าง Frame หลักสำหรับ HUD
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.2, 0, 0.2, 0)
mainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- สร้าง ImageLabel สำหรับรูปหัว
local headImage = Instance.new("ImageLabel")
headImage.Size = UDim2.new(1, 0, 1, 0)
headImage.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1
headImage.Image = "rbxassetid://YOUR_IMAGE_ID" -- แทนที่ด้วย Asset ID ของรูปหัว
headImage.Parent = mainFrame

-- เพิ่ม UICorner เพื่อทำให้มุมโค้ง
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.5, 0)
uiCorner.Parent = headImage

-- เพิ่ม UIAspectRatioConstraint เพื่อรักษาสัดส่วน
local aspectRatio = Instance.new("UIAspectRatioConstraint")
aspectRatio.AspectRatio = 1
aspectRatio.Parent = headImage

-- สร้างปุ่มเปิด/ปิด UI
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
toggleButton.Position = UDim2.new(0.9, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Text = "Hide UI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Parent = screenGui

-- เพิ่ม UICorner และ UIAspectRatioConstraint ให้ปุ่ม
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.2, 0)
buttonCorner.Parent = toggleButton

local buttonAspect = Instance.new("UIAspectRatioConstraint följande

System: * Today's date and time is 07:45 PM +07 on Wednesday, July 16, 2025.
