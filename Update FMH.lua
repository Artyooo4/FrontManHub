-- สคริปต์ฝังอยู่ใน LocalScript ภายใต้ StarterGui
local TweenService = game:GetService("TweenService")

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.Name = "HeadUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

-- สร้าง Frame หลักสำหรับ HUD
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.2, 0, 0.2, 0)
mainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = screenGui
mainFrame.Visible = true -- เริ่มต้นให้ UI แสดง

-- สร้าง ImageLabel สำหรับรูปหัว
local headImage = Instance.new("ImageLabel")
headImage.Size = UDim2.new(1, 0, 1, 0)
headImage.Position = UDim2.new(0, 0, 0, 0)
headImage.BackgroundTransparency = 1
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
toggleButton.Position = UDim2.new(0.9, 0, 0.05, 0) -- มุมขวาบน
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Text = "Hide UI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Parent = screenGui

-- เพิ่ม UICorner ให้ปุ่ม
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.2, 0)
buttonCorner.Parent = toggleButton

-- เพิ่ม UIAspectRatioConstraint ให้ปุ่ม
local buttonAspect = Instance.new("UIAspectRatioConstraint")
buttonAspect.AspectRatio = 2 -- ทำให้ปุ่มเป็นสี่เหลี่ยมผืนผ้า
buttonAspect.Parent = toggleButton

-- ตั้งค่า TweenInfo สำหรับอนิเมชัน
local tweenInfo = TweenInfo.new(
    0.5, -- ความยาวอนิเมชัน 0.5 วินาที
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out,
    0,
    false,
    0
)

-- ตัวแปรสถานะ UI
local isUIVisible = true

-- ฟังก์ชันอนิเมชันสำหรับแสดง/ซ่อน UI
local function toggleUI()
    isUIVisible = not isUIVisible
    toggleButton.Text = isUIVisible and "Hide UI" or "Show UI"
    
    if isUIVisible then
        mainFrame.Visible = true
        local tweenShow = TweenService:Create(headImage, tweenInfo, {ImageTransparency = 0})
        tweenShow:Play()
    else
        local tweenHide = TweenService:Create(headImage, tweenInfo, {ImageTransparency = 1})
        tweenHide.Completed:Connect(function()
            mainFrame.Visible = false
        end)
        tweenHide:Play()
    end
end

-- เริ่มต้นด้วยอนิเมชันแสดง UI
headImage.ImageTransparency = 1
local tween = TweenService:Create(headImage, tweenInfo, {ImageTransparency = 0})
tween:Play()

-- เชื่อมต่อปุ่มกับฟังก์ชัน
toggleButton.MouseButton1Click:Connect(toggleUI)

-- ปรับขนาด UI ตามขนาดหน้าจอ
local function adjustUIScale()
    local screenSize = game.Workspace.CurrentCamera.ViewportSize
    local scaleFactor = math.min(screenSize.X, screenSize.Y) / 1080
    mainFrame.Size = UDim2.new(0.2 * scaleFactor, 0, 0.2 * scaleFactor, 0)
    toggleButton.Size = UDim2.new(0.1 * scaleFactor, 0, 0.05 * scaleFactor, 0)
end

-- เรียกฟังก์ชันปรับขนาดเมื่อเริ่มต้นและเมื่อหน้าจอเปลี่ยนขนาด
adjustUIScale()
game.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(adjustUIScale)